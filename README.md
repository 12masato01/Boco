# Boco 
### 4/20仮完成（未実装機能あり、随時機能追加）

https://www.body-consult.com   ※ログインページから、ユーザー情報の入力無しでゲストログインが可能です。

![image](https://user-images.githubusercontent.com/56257719/79718877-1c91ea80-8318-11ea-9a43-007da7ef5f23.png)


# サービスの概要
身体に関する専門に相談できる、ヘルスケアのQ&Aサイト。病院に行かずとも気軽に・簡単に相談する事ができる。

もしQ&Aサイトでは解決する事ができなかった場合は、専門家と1対1で直接相談する事も可能。

# 解決する課題
医療の進歩により人生100年時代と称されるこの時代、人々の関心は「寿命」ではなく「健康寿命」へ向いている。

しかし実際には、身体に不調を抱えながら生活している人は少なくない。その理由の一つとして、病院へ通院する事に対する敷居の高さがある。

本サービスでは気軽に身体に関して、世の人々や専門家に相談できる場を設ける事により、敷居を下げる。
そしてこの場を通して、人々の身体の不調を軽減し、QOLを向上させる事を目的としている。

# マーケット
・身体に関する何かしらの不調を抱えており、それを改善したい人　

・身体に関する知識を身につけ、より健康増進に努めたい人

# 使用技術
### ●環境
Rails: 5.2.4　Ruby: 2.6.5　MySQL: 8.0.19

### ●インフラ
- AWS：EC2、RDS（MySQL）、S3、VPC、Route53、Elastic IP、ACM
- アプリケーションサーバー：Unicorn  
- Webサーバー：Nginx

### ●AWS構成図

![スクリーンショット 2020-04-25 12 27 27](https://user-images.githubusercontent.com/56257719/80270102-508e5680-86f0-11ea-8b35-82527e735677.png)

### ●ER図
![スクリーンショット 2020-04-20 22 24 21](https://user-images.githubusercontent.com/56257719/79756537-ba57da80-8355-11ea-9e44-86b9f70ebcb7.png)

※完成予定図

### ●アプリケーションの機能 
- ユーザーログイン・登録機能（Devise）
- Facebookログイン機能（Devise、OmniAuth）
- 質問のCRUD機能
- 質問に対する回答のCRUD機能
- 質問・回答に対するコメント機能（ポリモーフィック関連）
- 管理ユーザーの作成
- 管理ユーザー機能（ユーザー・質問の削除）
- お気に入り機能（質問のお気に入り登録・削除、お気に入り一覧ページ）
- 検索機能(ransack)
- 画像・動画投稿機能

### ●その他の技術
- Rspecでテストを記述
- 静的解析ツール（rubocop）の使用
- Git flowを活用し開発
- AWS ACMでSSL証明書を発行し、SSL化

### ●今後実装する機能
詳細は[issue](https://github.com/12masato01/Boco/issues)を御覧ください。
