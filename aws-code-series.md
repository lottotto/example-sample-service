# AWSのCodeシリーズに関する勉強メモ

## code commit


https://www.slideshare.net/AmazonWebServicesJapan/20201020-aws-black-belt-online-seminar-aws-codecommit-aws-codeartifact

### iamユーザの作成
↓ここみて  
https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/setting-up-ssh-unixes.html

接続&認証に成功するとこんな感じになる
```bash
$ ssh git-codecommit.us-east-2.amazonaws.com
The authenticity of host 'git-codecommit.us-east-2.amazonaws.com (52.95.20.253)' can't be established.
RSA key fingerprint is SHA256:3lBlW2g5xn/NA2Ck6dyeJIrQOWvn7n8UEs56fG6ZIzQ.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'git-codecommit.us-east-2.amazonaws.com' (RSA) to the list of known hosts.
You have successfully authenticated over SSH. You can use Git to interact with AWS CodeCommit. Interactive shells are not supported.Connection to git-codecommit.us-east-2.amazonaws.com closed by remote host.
Connection to git-codecommit.us-east-2.amazonaws.com closed.
```
Commit, PushはいつものGit通り。

### ブランチの保護
IAMポリシーでやるらしい。詳しくはここみて↓  
https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/how-to-conditional-branch.html

### 暗号化
Codecommit レポジトリを何かしらでも作成すると、KMSに鍵が作られるらしい

### フェデレーション
フェデレーション用のロールを作成して、所定の方法で、ロールと外部IDPを対応させると、よしなにやってくれるらしい。詳しくはここみて↓
https://docs.aws.amazon.com/ja_jp/codecommit/latest/userguide/temporary-access.html

### IaC
terraformだったり、CDKだったりでこのような開発系のサービスも対応できるのかな

- terraform: https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codecommit_repository
- cdk: https://docs.aws.amazon.com/cdk/api/v1/docs/aws-codecommit-readme.html

ありそう。
