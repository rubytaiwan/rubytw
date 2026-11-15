---
name: edm
description: Operate the Ruby Taiwan listmonk (edm.ruby.tw) — prepare EDM campaign drafts for the community lists. Use whenever the user mentions EDM, listmonk, 電子報, 寄信給社群, or "/edm".
---

# Ruby Taiwan EDM (listmonk)

- Instance: https://edm.ruby.tw/ ，社群 list id = **12**（KKTIX 報名者）；攤位名單另有各自的 list，用 `GET /api/lists` 查詢
- 憑證放在 repo 根目錄 `.env`（已 gitignore，絕不 commit、不印出）：`LISTMONK_API_USER`、`LISTMONK_API_SECRET`。範本見 `.env.example`，API user 請向 listmonk 管理員索取（每人各自一組，不共用）。
- API header：`Authorization: token USER:SECRET`

## 流程規則（寄信對外不可逆）

1. 不得把已退訂（unsubscribed）或 blocklisted 的人重新訂閱；寄信對象以 listmonk 的訂閱狀態為準。
2. campaign 只能建立／更新成 **draft**，**絕不啟動寄送**（不可呼叫 `PUT /api/campaigns/:id/status` 改成 running/scheduled）。啟動由使用者在後台按 Start campaign。

## 建立 EDM campaign draft

流程：
1. 讀取活動頁面（例如 Day 1），整理日期、地點、議程、報名連結。**不要臆測頁面沒寫的資訊**（如名額），有矛盾（例如時間）先問使用者。
2. 寫中英雙語 HTML 草稿（中文在前、英文在後，以 `<hr>` 分隔），用 `{{ .Subscriber.Name }}` 稱呼，含明確的 call to action（報名按鈕）。
3. **先在對話中把稿給使用者看，確認後才送進 listmonk**；稿件修改後也要再確認才更新 draft。
4. 建立 draft：`POST /api/campaigns`，body：`name`、`subject`、`lists: [目標 list id]`、`type: "regular"`、`content_type: "html"`、`messenger: "email"`、`body`（`template_id` 省略則用預設 template，內含退訂連結）。更新用 `PUT /api/campaigns/:id`（需帶完整欄位，含 `template_id`、`from_email`）。
5. 回報 campaign id 與狀態，提醒使用者：後台預覽 → Send test message 寄給自己 → 再自行 Start campaign（或排程）。

權限：API user 的 user role 需有 `campaigns:manage`（或 `campaigns:manage_all`），否則 403 `permission denied: campaigns:manage`。可用 `GET /api/profile` 查目前權限。建議使用專用 role，不要把此權限加在攤位等共用的 API role。
