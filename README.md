# Boco 
### 4/20仮完成（未実装機能あり、随時機能追加）

http://www.body-consult.com   ※ログインページから、ユーザー情報の入力無しでゲストログインが可能です。

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

# 参考資料
・[ER図](https://drive.google.com/drive/my-drive)
※完成予定図

# 使用技術
### ●環境
Rails: 5.2.4　Ruby: 2.6.5　MySQL: 8.0.19

### ●インフラ
- AWS：EC2、RDS（MySQL）、VPC、Route53、Elastic IP
- アプリケーションサーバー：Unicorn  
- Webサーバー：Nginx

### ●AWS構成図

![スクリーンショット 2020-04-20 21 38 32](https://user-images.githubusercontent.com/56257719/79752515-6518ca80-834f-11ea-9f9e-edae66a1024a.png)

### ●アプリケーションの機能 
- ユーザーログイン・登録機能（Devise）
- Facebookログイン機能（Devise、OmniAuth）
- 質問のCRUD機能
- 質問に対する回答のCRUD機能
- 質問・回答に対するコメント機能（ポリモーフィック関連）
- 管理ユーザーの作成
- 管理ユーザー機能（ユーザー・質問の削除）

### ●その他の技術
- Rspecでテストを記述
- 静的解析ツールの使用
- Git flowを活用し開発

### ●今後実装する機能
詳細は[issue](https://github.com/12masato01/Boco/issues)を御覧ください。
