---
title: "Use Hugo Tutorial"
date: 2018-12-12T00:49:50-06:00
draft: true
---

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
1. `hugo server` in powershell and open "localhost:1313" in your browser and you can see your personal static website

## Add content

1. add a ne post: `hugo new post/first post.md`

Since the post is set as "draft" as default, the post will be shown on your personal site, so you need to:

1. `ctrl + c` to stop `hugo server`
2. `hugo server -D` which enables preview of your current site
3. `hugo new about.md`: to create a new .md document outside of posts
4. `[About me](/about)`: You can cross-reference other posts using `[](/other-post)`
