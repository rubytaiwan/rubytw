#!/usr/bin/env ruby
# frozen_string_literal: true

# 把 KKTIX 匯出的 Excel 匯入 listmonk list。
# 用法: ruby scripts/import_kktix.rb kktix.xlsx [--dry-run]
# 需要 .env: KKTIX_LIST_API_USER / KKTIX_LIST_API_SECRET   (gem install roo)
require 'roo'
require 'net/http'
require 'json'
require 'uri'

BASE = 'https://edm.ruby.tw'
LIST_ID = 12

path, flag = ARGV
abort "Usage: #{$PROGRAM_NAME} FILE.xlsx [--dry-run]" unless path
dry = flag == '--dry-run'

File.foreach(File.expand_path('../.env', __dir__)) do |l|
  k, v = l.strip.split('=', 2)
  ENV[k] ||= v if k && v && !k.start_with?('#')
end

sheet = Roo::Spreadsheet.open(path).sheet(0)
header = sheet.row(1).map { |h| h.to_s.strip }
rows = (2..sheet.last_row).map { |i| header.zip(sheet.row(i)).to_h }

# KKTIX 自訂問題欄位都排在 Email 之後，一律放進 attribs
extra = header[(header.index('Email') + 1)..]

def api(method, path, body = nil) # rubocop:disable Metrics/AbcSize
  uri = URI("#{BASE}#{path}")
  req = Net::HTTP.const_get(method.capitalize).new(uri)
  req['Authorization'] = "token #{ENV.fetch('KKTIX_LIST_API_USER')}:#{ENV.fetch('KKTIX_LIST_API_SECRET')}"
  req['Content-Type'] = 'application/json'
  req.body = body.to_json if body
  res = Net::HTTP.start(uri.host, uri.port, use_ssl: true) { |h| h.request(req) }
  [res.code.to_i, JSON.parse(res.body)]
end

stats = Hash.new(0)
rows.each do |r| # rubocop:disable Metrics/BlockLength
  email = r['Email'].to_s.strip.downcase
  # 只匯入有效票券（排除取消/退款）
  if email.empty? || r['票券狀態'] != 'activated'
    stats[:skipped] += 1
    next
  end

  attribs = extra.to_h { |k| [k.split(' / ').first, r[k].to_s.strip] }.reject { |_, v| v.empty? }
  attribs['kktix_order'] = r['訂單編號'].to_s
  payload = { email: email, name: r['姓名'].to_s.strip, status: 'enabled',
              lists: [LIST_ID], attribs: attribs, preconfirm_subscriptions: true }

  if dry
    puts payload.to_json
    next
  end

  code, = api(:post, '/api/subscribers', payload)
  if code == 409 # 已存在 → 只加入 list，不覆蓋既有資料
    _, found = api(:get, "/api/subscribers?query=#{URI.encode_www_form_component("subscribers.email='#{email}'")}")
    sub = found.dig('data', 'results', 0)
    in_list = sub['lists'].find { |l| l['id'] == LIST_ID }
    # 尊重退訂：blocklisted 或曾退訂 list 12 的人不重新訂閱
    if sub['status'] == 'blocklisted' || in_list&.dig('subscription_status') == 'unsubscribed'
      puts "OPTOUT #{email}"
      stats[:skipped_optout] += 1
      next
    end
    code, = api(:put, '/api/subscribers/lists',
                { ids: [sub['id']], action: 'add', target_list_ids: [LIST_ID], status: 'confirmed' })
    stats[code == 200 ? :existing_added : :failed] += 1
  else
    stats[code == 200 ? :created : :failed] += 1
  end
  puts "#{code} #{email}"
end

puts stats
