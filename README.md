# oop-server

## 当面開発用ReadMeになります

### DBについて

- classrooms
- access_points
- users
- logs

の４つ。

users -(n - 1)- access_points -(n - 1)- classrooms
logsは今のところ独立

各テーブルとか詳細とかについては `/db/schema.rb` を参照 変更あるかもしれないし()
※ log に作った`log_date:timestamp` 、`created_at` 見ればいいしいらなかったかも