build:
	rm -rf public
	hugo

deploy: build
	aws s3 sync public/ s3://www.caimiao0714.com --acl public-read --delete
	aws configure set preview.cloudfront true
	aws cloudfront create-invalidation --distribution-id E3KO5BW57UHAV3 --paths '/*'