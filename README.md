# BookMarks
This application is a book-specific SNS service that promotes encounters with good books created by Ruby/Ruby on rails.
[https://www.book-marks-app.net/]
![demo](https://raw.github.com/wiki/Hisaaki-Kato/BookMarks/images/screenshot.png)

## Features and technical topics

* Authentication/Authorization

* For microposts, post, comment, like

* Pagination (kaminari)

* Create "学びボード" (book summary)

* Follow users

* Display user's feed

* Search and register books (GoogleBooksAPI)

* Display popular books

* Upload images (CarrierWave)

* Login as admin user

* Login as test user

* Tests (RSpec/FactoryBot/Capybara)

* Infrastructure (AWS: VPC/EC2/ELB)

* Database (AWS-RDB (MySQL))

* Linting codes (RuboCop)

* Docker

* CI/CID (CircleCI)

## Requirement

* rbenv 1.1.2

* Ruby 2.7.1

* Ruby on Rails 5.2.4.3

* MySQL 5.7

## Usage

1. Clone this repository, and move to application directory.
```bash
$ git clone git@github.com:Hisaaki-Kato/BookMarks.git
$ cd BookMarks/
```

2. Excute db migration and runserver.
```bash
$ rails db:create
$ rails db:migrate
$ rails s
```
## Author
Hisaaki-kato