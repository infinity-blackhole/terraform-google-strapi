deploy:
	gcloud run deploy \
		strapi \
		--source . \
		--set-env-vars HOST="0.0.0.0" \
		--set-env-vars JWT_SECRET="TSXCVmhGrD3B75RDj&ri8WqocQQjd*n*zgq%u#vs%y8!BVeowbchsuZ^3x4Z" \
		--set-env-vars APP_KEYS="VW/K6zUU9U//XrOLb3/mFA==,Xx6G9QbFdKgCweDpapRs2Q==,iKqjzF1TpDwTRhKxdRlKWQ==,P2WV6LkD2EcTVmuFsXO3xA==" \
		--set-env-vars API_TOKEN_SALT="EKk7cI9PriLt0QgMrm0w6w==" \
		--set-env-vars ADMIN_JWT_SECRET="wmISOcvjZPnHthf3XeLhEQ==" \
		--set-env-vars DATABASE_HOST="/cloudsql/sandbox-348610:europe-west1:strapi-49a4ab27" \
		--set-env-vars DATABASE_NAME="strapi" \
		--set-env-vars DATABASE_USERNAME="strapi" \
		--set-env-vars DATABASE_PASSWORD="v4VGXGIZhkzDJEkEnNcEkmSvfpfGGLZfbh40LQEEgu8TqCUgPFP7GvmXTknKg3rSlvqIy8WdPSNKxlKR"
