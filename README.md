# BookMarks
このアプリケーションは、Ruby/Ruby on railsによって作成された良書との出会いを促進する書籍特化型SNSサービスです。
[https://www.book-marks-app.net/]
![demo](https://raw.github.com/wiki/Hisaaki-Kato/BookMarks/images/screenshot.png)

## 機能・使用技術一覧

* 認証/認可

* マイクロポストの投稿、いいね、コメント

* ページネーション (Will_paginate)

* 学びボード(書籍の要約)の投稿

* ユーザーのフォロー

* Feedの表示

* 書籍検索、登録 (GoogleBooksAPI)

* 人気書籍の表示

* 画像アップロード (Carrierwave)

* 管理ユーザーログイン

* テストユーザーログイン

* テスト (RSpec/FactoryBot/Capybara)

* インフラ (AWS: VPC/EC2/ELB)

* データベース (AWS-RDB (MySQL))

* コードの静的解析 (RuboCop)

## Requirement

* rbenv 1.1.2

* Ruby 2.7.1

* Ruby on Rails 5.2.4.3

* MySQL 14.14

## Usage

1. リポジトリをcloneし、アプリケーションディレクトリに移動してください。
```bash
$ git clone ~~~
$ cd BookMarks/
```

2. 下記のコマンドを実行し、サーバが起動することを確認してください。
```bash
$ rails db:create
$ rails db:migrate
$ rails s
```
## Author
Hisaaki-kato