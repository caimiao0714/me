---
title: "Use Hugo Tutorial"
date: 2018-12-12T00:49:50-06:00
draft: true
---

These tutorials are generated from the Udemy Course [Create A Static Website With Hugo](https://www.udemy.com/static-site-with-hugo/) Teached by [SmarterThings Tech](https://www.udemy.com/user/627fba2e-7370-448f-9392-0a5d801c9252/)

# Using Hugo to create websites on Windows

## Set up Hugo

1. install `hugo`, check through `hugo --version` in powershell
2. intall `git`, check through `git --version` in powershell
3. change to your current directory `cd c:/documents`
4. `hugo new site your-site-name`
5. `cd ./your-site-name/`
6. open the folder using VisualStudio by `code .`
7. `git init` and `git commit`
1. Add a theme `git submodule add your-own-github-link themes/theme-name`
1. change the name of the theme in `config.toml`
1. `hugo server` in powershell and open `localhost:1313` in your browser and you can see your personal static website

## Add content

1. add a ne post: `hugo new post/first post.md`

Since the post is set as "draft" as default, the post will be shown on your personal site, so you need to:

1. `ctrl + c` to stop `hugo server`
2. `hugo server -D` which enables preview of your current site
3. `hugo new about.md`: to create a new .md document outside of posts
4. `[About me](/about)`: You can cross-reference other posts using `[](/other-post)`

## Save the static site

1. `hugo`: build all the site files and save them is a new folder called `public`.

`public` contains all the figures and files that contain each one of your posted pages. Hugo also copies everything from the static folder and merges your static content with any images or javascript files provided by the theme. All we need to do for now is to upload the files to a server.

Since we will not want to keep track of the files in the public folder because they will be regenerated everytime we run the `hugo` command. Therefore, we can:

1. add a `.gitignore` file to this project.
2. type `public/`: ignore all the files in the `public` folder
3. `git add .gitignore` and `git commit`

## Deployment

### AWS

1. push all the files to [GitHub](https://github.com/)
2. Set up services such as `Travis C.I.`

With `Travis C.I.`, you can set up a task that runs every time you change or add a file in your project. This task will build the site file using Hugo and then push the contents of the public folder to Amazon S3. Amazon S3 will store the site files and act as a web server. You could point your browser directly at the S3 bucket but it is a better idea to set up Amazon CloudFront in front of three. 

- CloudFront will replicate and distribute your site to multiple regions so it loads as fast as possible for your visitors.
- CloudFront will also makes it easy to add http security to your website for more security.

GitHub and Travis CI are free to use, and Amazon service only charge a few cents per Gigabyte of data you store and transfer. We only need to set up this pipeline once and after that it works automatically.

- `git add .`, `git commit -m ""` and `git push -u origin master`
- link your github account with Travis CI
- create a `.travis.yml` in your site folder and the following code to the `.travis.yml` file.

~~~~
language: go
install:
- go get -v github.com/spf13/hugo
script:
- hugo version
- make build
branches:
 only:
 - master
~~~~

- create anther `Makefile` and add the following content to the file:

~~~~~
build:
	rm -rf public
	hugo
~~~~~

You can add a credentials for `Travis CI` in the `README.md` to get a vectorized image for the building status on `Travis CI` using the following code:

~~~~~
[![Travis CI Build Status](https://travis-ci.org/caimiao0714/me.svg?branch=master)](https://travis-ci.org/caimiao0714/me)
~~~~~

- Buy your personal domain name on [https://www.namecheap.com/](https://www.namecheap.com/)

- Log in on Amazon [AWS](http://console.aws.amazon.com)
- AWS services: search for `S3`
- create a `bucket` using your bought domain
- copy the Endpoint at static website hosting 'http://www.caimiao0714.com.s3-website.us-east-2.amazonaws.com'
- Open Services -> Networking & Content Delivery -> CloudFont -> create a new distribution -> Web -> Get Started
- Paste 'http://www.caimiao0714.com.s3-website.us-east-2.amazonaws.com' to Origin Domain Name
- redirect HTTP to HTTPS
- Object Caching: Customize
- Copy Maximum TTL 'Maximum TTL' and paste it to Minimum and Default TTL
- Compress Objects Automatically -> Yes
- Change Alternate Domain Names (CNAMEs) to your bought domain name 'www.caimiao0714.com'
- MISSING the option to Custom SSL certificate here
- Request or import a Certificate with ACM (make sure at the top right it says N. Virginia), verify the use of this domain using your email
- Default Root Object: `index.html`

## Configure DNS

Namecheap.com -> Domain List -> Domain -> Adcanced DNS -> ADD NEW RECORD 

You need to add two records here:

1. CNAME Record
  Host = www
  Value = Copy paste Domain name from `CloudFront Distributions`, something like "XXXXXXXX.cloudfront.net"
2. URL Redirect Record
  Host = @
  Value = https://www.caimiao0714.com

Then clear out the two records (*CNAME Record* and *URL Redirect Record*) that are already there.

## CloudFront distribution

Amazon AWS --> search IAM -> Users -> Add user (travis_www.caimiao0714.com) -> click Programmatic access -> next -> Attach existing policies directly -> create policy -> S3

### S3

- Actions:
  ListBucket
  DeleteObject
  PutObject
  PutObjectAcl
- Amazon Resource Name (ARN): copy from S3 management console -> select your bucket in the list -> Copy Bucket ARN

### Amazon CloudFront

Actions: CreateInvalidation