
# 俺達のハンバーガー

ハンバーガーショップについて感想を共有し、
近場のハンバーガーショップやその他ジャンルのレストランを探すことができるwebアプリです。
転職用のポートフォリオとして作成しました。

## リンク

https://www.ourhamburger.site/

![toppage](https://user-images.githubusercontent.com/53758098/70888286-56c64500-2023-11ea-9f00-a9ade19cf59e.png)


***テストユーザーログイン:***

- テストログインボタンを押してください
※観覧用としてご自由にお使いください

- スマホでご覧の場合、ホーム画面の右側をスライドしていただくとメニューが現れます。

## 特に見ていただきたい部分

- Dockerを使いこなし、ECS/ECRで本番環境をEC2インスタンス内で実行していること
- FrontエンドにNuxt.jsを採用し、SSR（サーバーサイドレンダリング）で発信している点
- 外部API（HotPepparAPI,GoogleAPI）を利用し機能を追加している点
- AWSを使いALBを通すことで常時SSL通信を行っている点

## 使用技術

***開発環境:***
- docker
  - docker-compose

***サーバーサイド:***
- mysql:5.7
- Ruby:2.6.3
  - Rails:5.2.3  
- AWS
  - ECS/ECR
  - EC2
  - ALB
  - RDS for MySQL
  - S3
  - CloudFront
  - Route53
  - Certificate Manager
  - VPC
  - CloudWatch
  - IAM
  - CodePipeline
    - CodeBuild
    - CodeDeploy

***gem:***
- rack-cors
- devise
  - devise_token_auth
- carrierwave
- fog-aws
- active_model_serializers
- pry
- rubocop
- rspec-rails'
  - factory_bot_rails'
  - rails-controller-testing'
  - spring-commands-rspec

***フロントエンド:***
- node:12.9.0
  - Nuxt:2.0
  - Vuetify(UI)

***javaScriptパッケージ:***
- nuxtjs/axios
- nuxtjs/dotenv
- nuxtjs/proxy
- cross-env
- nuxt-webfontloader
- vee-validate
- vuex-persistedstate
  - js-cookie
- fortawesome/fontawesome-free
- eslint
- prettier
- lodash

## クラウドアーキテクチャ

![AWS Design (updated) (3)](https://user-images.githubusercontent.com/53758098/71232834-f262f880-2336-11ea-80f4-35e241f9248d.png)

AWSCodePipelineを用いてGithubのmasterブランチへのプッシュをウェブフックにしてECSサービスの自動デプロイ(blue/green)を実現しています。

## 機能一覧

- ユーザー登録、ログイン機能全般
- 記事投稿機能
- 外部API(HotPeppar,googlemap)を利用してコンテンツを表示
- いいね機能
- コメント機能
- 投稿記事削除
- クライアントサイドでのバリデーション

## 開発環境

windowns10 Home EditionのPCを利用しています。
このOSではDockerが使うことが難しいため、vmwareで仮想Linux(ubuntu)を立ち上げて
Linux上でdockerを使い開発しています。

開発当時はvagrantの存在を知らなかったため、今後windownsで開発していくならvagrantの導入を検討したいですが、それよりも早くエンジニアリングでお金を稼ぐことでMacを購入したいと思っています。

## その他

- 今後はテストの導入を、CI/CDパイプラインなどを導入していきたい。

## 追記

- フロントエンドにlodash及びTopicのソート機能の追加(12/17)
- バックエンドのテストを書き始めました(12/18)
- CodePipeLineを導入しました（12/20)


