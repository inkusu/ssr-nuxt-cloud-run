# 実行に必要な各種変数の一覧
# Cloud runを実行するGoogle Project ID
#=========================#
# Google Cloud run基本設定
#=========================#
PROJECT_ID=
# デプロイするイメージ名
IMAGE=ssr-nuxt-cloud-run
# デプロイ名
DEPLOY_NAME=ssr-nuxt-cloud-run
# リージョン
REGION=asia-northeast1

#=========================#
# データベース設定情報
#=========================#
# クラウドSQL名
CLOUD_SQL_INSTANCE_NAME=ssr-nuxt-cloud-run-sql
# DBホスト
DB_HOST=/cloudsql/$(PROJECT_ID):$(REGION):$(CLOUD_SQL_INSTANCE_NAME)

#=========================#
# メール設定
#=========================#
SMTP_MODE=sandbox
SMTP_HOST=smtp.gmail.com
SMTP_PORT=465
SMTP_TLS=true
SMTP_USER=
SMTP_PASS=

# Googleのアプリケーションクレデンシャルの保存パス
GOOGLE_APPLICATION_CREDENTIALS=

# Cloud run 展開用のイメージをビルド
app-image-build:
	docker build --no-cache=true -t gcr.io/$(PROJECT_ID)/$(IMAGE) .

# Cloud run 展開用のコンテナを起動確認用(DBも立てておく必要あり)
app-image-run:
	docker run -p 8080:8080 gcr.io/$(PROJECT_ID)/$(IMAGE)

# リモートでビルドしてレジストリーに登録
gcloud-app-build-submit:
	gcloud config set project $(PROJECT_ID)
	gcloud builds submit --tag gcr.io/$(PROJECT_ID)/$(IMAGE)

# gcloud-app-build-submitでコンテナをビルドしてから実行 リージョン東京
gcloud-app-test-deploy:
	gcloud beta run deploy st-$(DEPLOY_NAME) \
	  --project $(PROJECT_ID) \
	  --image gcr.io/$(PROJECT_ID)/$(IMAGE) \
	  --region $(REGION) \
	  --platform managed \
	  --set-env-vars PROJECT_ID=$(PROJECT_ID) \
	  --set-env-vars NODE_ENV=test

# クラウドSQLと連携するパターン
gcloud-app-test-deploy-with-db:
	gcloud beta run deploy st-$(DEPLOY_NAME) \
      --project $(PROJECT_ID) \
      --image gcr.io/$(PROJECT_ID)/$(IMAGE) \
      --region $(REGION) \
      --platform managed \
      --add-cloudsql-instances $(PROJECT_ID):$(REGION):$(CLOUD_SQL_INSTANCE_NAME) \
      --set-env-vars PROJECT_ID=$(PROJECT_ID) \
      --set-env-vars NODE_ENV=test \
      --set-env-vars DB_USERNAME=staging \
      --set-env-vars DB_PASSWORD= \
      --set-env-vars DB_HOST=$(DB_HOST) \
      --set-env-vars DB_NAME=staging \
      --set-env-vars SMTP_MODE=$(SMTP_MODE) \
      --set-env-vars SMTP_HOST=$(SMTP_HOST) \
      --set-env-vars SMTP_PORT=$(SMTP_PORT) \
      --set-env-vars SMTP_TLS=$(SMTP_TLS) \
      --set-env-vars SMTP_USER=$(SMTP_USER) \
      --set-env-vars SMTP_PASS=$(SMTP_PASS)


# gcloud-app-build-submitでコンテナをビルドしてから実行 リージョン東京
gcloud-app-production-deploy:
	gcloud beta run deploy $(DEPLOY_NAME) \
	  --project $(PROJECT_ID) \
	  --image gcr.io/$(PROJECT_ID)/$(IMAGE) \
	  --region $(REGION) \
	  --platform managed \
	  --set-env-vars PROJECT_ID=$(PROJECT_ID) \
	  --set-env-vars NODE_ENV=production

# クラウドSQLと連携するパターン
gcloud-app-production-deploy-with-db:
	gcloud beta run deploy $(DEPLOY_NAME) \
      --project $(PROJECT_ID) \
      --image gcr.io/$(PROJECT_ID)/$(IMAGE) \
      --region $(REGION) \
      --platform managed \
      --add-cloudsql-instances $(PROJECT_ID):$(REGION):$(CLOUD_SQL_INSTANCE_NAME) \
      --set-env-vars PROJECT_ID=$(PROJECT_ID) \
      --set-env-vars NODE_ENV=production \
      --set-env-vars DB_USERNAME=production \
      --set-env-vars DB_PASSWORD= \
      --set-env-vars DB_HOST=$(DB_HOST) \
      --set-env-vars DB_NAME=production \
      --set-env-vars SMTP_MODE=$(SMTP_MODE) \
      --set-env-vars SMTP_HOST=$(SMTP_HOST) \
      --set-env-vars SMTP_PORT=$(SMTP_PORT) \
      --set-env-vars SMTP_TLS=$(SMTP_TLS) \
      --set-env-vars SMTP_USER=$(SMTP_USER) \
      --set-env-vars SMTP_PASS=$(SMTP_PASS)

