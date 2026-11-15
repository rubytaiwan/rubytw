---
name: edm
description: Operate the Ruby Taiwan listmonk (edm.ruby.tw) — import KKTIX Excel exports into the community list (id 12) and prepare EDM campaigns. Use whenever the user mentions EDM, listmonk, 電子報, 匯入 KKTIX 名單, or "/edm".
---

# Ruby Taiwan EDM (listmonk)

- Instance: https://edm.ruby.tw/ ，社群 list id = **12**
- 憑證放在 repo 根目錄 `.env`（已 gitignore，絕不 commit、不印出）：`KKTIX_LIST_API_USER`、`KKTIX_LIST_API_SECRET`。範本見 `.env.example`，API user 請向 listmonk 管理員索取（每人各自一組，不共用）。
- API header：`Authorization: token USER:SECRET`

## 匯入 KKTIX 名單

KKTIX 匯出的 `.xlsx` 用 `scripts/import_kktix.rb`（需 `gem install roo`）：

```bash
scripts/import_kktix.rb FILE.xlsx --dry-run   # 1. 先預覽，不送出
scripts/import_kktix.rb FILE.xlsx             # 2. 確認後正式匯入

# 多個檔案
for f in ~/Downloads/event-rubyjam*.xlsx; do scripts/import_kktix.rb "$f" --dry-run; done
```

行為：
- 只匯入 `票券狀態 == activated`（取消／退款會跳過）
- Email 之後的自訂問題欄位存進 subscriber attribs，另存 `kktix_order`
- 已存在的 email 只加進 list 12，不覆蓋資料
- 已退訂 list 12 或 blocklisted 的人會跳過並印 `OPTOUT`，**不得重新訂閱**
- 結尾統計：created / existing_added / skipped / skipped_optout / failed

## 流程規則（寄信對外不可逆）

1. 一律先 `--dry-run`，把筆數與樣本給使用者看，**取得確認才正式執行**。
2. `preconfirm_subscriptions: true`（不寄確認信）只在報名頁有同意收信勾選時才適用；不確定就問使用者，或改 `false` 讓 listmonk 寄 opt-in 信。
3. campaign 只能建立／更新成 **draft**，**絕不啟動寄送**（不可呼叫 `PUT /api/campaigns/:id/status` 改成 running/scheduled）。啟動由使用者在後台按 Start campaign。
4. 匯入後回報統計，特別是 `skipped_optout` 與 `failed`。

## 用到的 API

`POST /api/subscribers`（409 = 已存在）、`GET /api/subscribers?query=subscribers.email='x'`、`PUT /api/subscribers/lists`。

## 建立 EDM campaign draft

流程：
1. 讀取活動頁面（例如 Day 1），整理日期、地點、議程、報名連結。**不要臆測頁面沒寫的資訊**（如名額），有矛盾（例如時間）先問使用者。
2. 寫中英雙語 HTML 草稿（中文在前、英文在後，以 `<hr>` 分隔），用 `{{ .Subscriber.Name }}` 稱呼，含明確的 call to action（報名按鈕）。
3. **先在對話中把稿給使用者看，確認後才送進 listmonk**；稿件修改後也要再確認才更新 draft。
4. 建立 draft：`POST /api/campaigns`，body：`name`、`subject`、`lists: [12]`、`type: "regular"`、`content_type: "html"`、`messenger: "email"`、`body`（`template_id` 省略則用預設 template，內含退訂連結）。更新用 `PUT /api/campaigns/:id`（需帶完整欄位，含 `template_id`、`from_email`）。
5. 回報 campaign id 與狀態，提醒使用者：後台預覽 → Send test message 寄給自己 → 再自行 Start campaign（或排程）。

權限：API user 的 user role 需有 `campaigns:manage`（或 `campaigns:manage_all`），否則 403 `permission denied: campaigns:manage`。可用 `GET /api/profile` 查目前權限。建議使用專用 role，不要把此權限加在攤位等共用的 API role。
