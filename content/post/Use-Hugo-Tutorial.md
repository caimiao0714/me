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

1. `git add .`, `git commit -m ""` and `git push -u origin master`
1. link your github account with Travis CI
1. create a `.travis.yml` in your site folder and the following code to the `.travis.yml` file.

~~~~
language: go
install:
- go get -v github.com/caimiao0714/me
script:
- hugo version
- make build
branches:
 only:
 - master
~~~~

1. create anther `Makefile` and add the following content to the file:

~~~~~
build:
 rm -rf public
 hugo
~~~~~
