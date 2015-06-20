+++
title = "Setting up your own free blog"
date = "2015-06-08T22:27:00+02:00"
description = "How to have your own blog hosted on Github Pages, using Hugo"
categories = [ "metablog", "git", "Github" ]
series = [ "Improving the Blog" ]
slug = "setting-up-your-own-free-blog"
project_url = "https://otaviokr.github.io"
toc = true
+++

There are many things I find interesting about the way this blog is deployed:

- It is only static pages, so you don't have to worry about huge frameworks, database management etc.
- Pages are written in Markdown language, so you have a clean and understandable text while writing.
- You can host it and many different places. I'm choosing the Github Pages, so both my website project and the website 
itself are under a version control system.
- I can share my ideas much easily, because the code is already hosted on Github, available to anyone curious enough to 
sneak a peek.
- It's easy!
- It's free!

I'm assuming you already have a valid account at [Github](https://github.com/), installed [Git](http://www.git.com) on 
your machine and downloaded [Hugo](http://gohugo.io/). No IDE is required for these tasks: everything can be managed 
just with your favorite text editor (I recommend [Notepad++](https://notepad-plus-plus.org/) if you're in a Windows 
environment) and a terminal/prompt.
 
I'll be using my repositories throughout this post as an example, so anywhere you read *otaviokr-blog* you may change 
by *source code repository named as you like it* while *otaviokr.github.io* means *<your_username>.github.io*. Notice 
that Github allows you to have a website for a particular repository, but that's not what we're aiming here: this is to 
build the user's website - while you may have many project websites (one for each project you have), you can only have 
one user website.

So here's the steps to create your own blog:

# Create 2 different repositories

The source repository is where the website source code will be; you'll also need a Github Pages default repository.
Feel free to name the first one as you like - mine is [otaviokr-blog](https://github.com/otaviokr/otaviokr-blog). Now, 
create another repository, following the pattern `<your_username>.github.io`, as in 
*[otaviokr.github.io](https://github.com/otaviokr/otaviokr.github.io)*. This is the default name used by Github Pages, 
so when you create this repository, Github will understand that you want to have a website at 
*http://your_username.github.io*. If you use a different repository name, it won't work - at least, not out-of-the-box.

If you need help to create the repositories, you may use 
[Github's documentation](https://help.github.com/articles/create-a-repo/) as a guideline.

# Setting the source repository

Now it's time to work with the source repository, where the raw code of your site will be - I'll be using my repos as 
example, 
we'll handle *otaviokr-blog* now. First, open the terminal, enter the folder where you want to keep the local 
repositories and clone the first repository to your machine:

{{< highlight batch "linenos=inline" >}}
git clone otaviokr-blog
{{< /highlight >}}

There's nothing there yet, so we'll add the blog skeleton manually[1]. Just create the following folders:

{{< highlight batch "linenos=inline" >}}
mkdir content
mkdir layouts
mkdir public
mkdir static
mkdir themes
{{< /highlight >}}

Brief explanation about the folders:

- *content*: where your raw posts will be;
- *layouts*: Hugo demands this folder, but I haven't use it so far;
- *public*: where the compiled site will be generated;
- *static*: to keep your static files, like images;
- *themes*: where the blog template are stored.

Now, create the configuration file on the root path (otaviokr-blog/) and name it config.yaml. Be careful to use just 
2 spaces for identation - YAML does not respond well to tabs. There are other optional parameters you can configure, 
and the theme you'll choose probably will have its own settings, but for now, what you need is just this - change the 
values whenever necessary!

{{< highlight yaml "linenos=inline" >}}
---
contentdir: "content"
layoutdir: "layouts"
publishdir: "public"
taxonomies:
  category: "categories"
  series: "series"
baseurl: "http://otaviokr.github.io"
title: "Otaviokr's Blog"
canonifyurls: true
{{< /highlight >}}

# Your own local blog

Before sending it to the web, we'll configure it and test it locally, to see if everything is working as expected. 
First, you'll need a theme (aka template) for you blog. Hugo has a 
[great variety of themes](https://github.com/spf13/hugoThemes) already, and you can create your own if you want, but, 
for now, let's just pick one to see the magic happening. I'm using [hurock](https://github.com/TiTi/hurock), but you 
can choose your personal favorite.

At the terminal, just enter inside `themes/` and clone the theme you want:

{{< highlight batch "linenos=inline" >}}
cd themes
git clone https://github.com/TiTi/hurock.git
{{< /highlight >}}

Then append the parameters required by the theme in your `config.yaml` file. Hurock gives already a 
[template](https://github.com/TiTi/hurock#config) with everything configured. Hurock also expects your picture saved as 
`static/media/me.jpg`.

Now, let's create a simple post to check our blog. You may simple create a text file and copy the header or use Hugo:

{{< highlight batch "linenos=inline" >}}
hugo new posts/2015/hello.md
{{< /highlight >}}

File will be created at `content/posts/2015/hello.md`. Open it, change the configuration header if you want and enter 
some text after the header. Markdown syntax is enabled, so try to do something nice! When you're done, save and exit.

Now, run:

{{< highlight batch "linenos=inline" >}}
hugo server --watch
{{< /highlight >}}

This will compile the website and create a server where you can see your blog. Open you web browser and access 
`localhost:1313`. You should see the blog and your first post - if not, check for error messages in the terminal and 
review all the steps. If the blog is fine, Ctrl+C in the terminal to kill the server and delete everything under 
`public/` folder - don't worry, we'll generate it again later. Create an empty file named `.gitkeep` inside any folder 
that has no files - I believe it's `layouts/` and  `public/` - and commit the first version of you website source code:

{{< highlight batch "linenos=inline" >}}
git add -A
git commit -m "First commit."
git push origin master
{{< /highlight >}}

# Putting the website online

Now we know that `public/` is where the website actually is, so let's clone the webiste repository *into* `public/`. 
That way, we'll just need to generate the site and push the commit to have the new article online. 

{{< highlight batch "linenos=inline" >}}
git clone https://github.com/otaviokr/otaviokr.github.io.git public/
{{< /highlight >}}

The idea then is to run hugo to generate the site, add all generated files to the website repository and push changes.

{{< highlight batch "linenos=inline" >}}
hugo
cd public
git add -A
git commit -m "First post: Hello."
git push origin master
{{< /highlight >}}

It might take a while before you can check your site for the first time, but it is there! Just open a browser and go to 
`http://your_username.github.io`. There you go, now for each new post, just run the last piece of command to add it, 
commit it and deploy it.

# Bonus round: making things easier

Whenever a developer hears the sentence *you just need to do this thing again and again*, he quickly starts thinking 
what sort of script could do that automatically, am I right? So, let's improve a little our project.

First, let's avoid having source and compiled code in the same repository. If you didn't created a `.gitignore` file 
while creating the *otaviokr-blog* repository, now it's the time. You may put anything you find relevant here, but we 
must algo include `public` so that folder is not in this project radar anymore.

Now, the automation script. Let's create a `bin/` folder where we'll keep it and inside it create a script called 
`publish.bat` - I'm in a Windows environment, but if you're in Linux, call it `publish.sh` and change the code as 
necessary... I'll try to create an example later, but you can check the 
[excellent original post](http://gohugo.io/tutorials/github-pages-blog/) on which I based my version.

{{< highlight batch "linenos=inline" >}}
@echo off
echo "Deploying updates to GitHub..."

cd ..

REM Build the project.  If using a theme, and it is not set in config.yaml, 
REM replace by `hugo -t <yourtheme>`
hugo

REM Go To Public folder
cd public

REM Add changes to git.
git add -A

REM Commit changes. Count the number of arguments: 
REM if user has not given any, use default message.
set argC=0
for %%x in (%*) do Set /A argC+=1

For /f "tokens=2-4 delims=/ " %%a in ('date /t') do (set mydate=%%c-%%a-%%b)
For /f "tokens=1-2 delims=/:" %%a in ('time /t') do (set mytime=%%a%%b)
set msg=rebuilding site %mydate%_%mytime%
if %argC% equ 1 (
    set msg=$1
)
git commit -m "%msg%"

REM Push source and build repos.
git push origin master

REM Come Back
cd ../bin

{{< /highlight >}}

That's it! Just commit the new changes and now, whenever you create a new post, all you have to do is commit/push 
*otaviokr-blog* and, after, run `cd bin; publish.bat`. Unless, you're using Windows...

# Bonus round 2: The eternal struggle on Windows - LF <=> CRLF 

I won't explain much about line endings conflict because what you need to know is that the return carriage (aka 
new-line character) is different between Windows and Linux. Because Github favours Linux standard, whenever you try to 
commit something using Windows end-of-line char, you'll receive a fatal error and the operation will be aborted. To 
avoid that, I'm using unix2dos to convert the files to Windows standard (CRLF).
 
It is important to notice that this is only needed to *otaviokr.github.io* repository; in theory, all files at 
*otaviokr-blog* are already using the correct EOL char. First thing is to modify repository configuration, editing 
`.git/config` file:

{{< highlight ini "linenos=inline,hl_lines=9 10" >}}
[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
	hideDotFiles = dotGitOnly
	eol = native
	autocrlf = true
[remote "origin"]
	url = https://github.com/otaviokr/otaviokr.github.io.git
	fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
{{< /highlight >}}

Then download **unix2dos** program at their official site and extract the zip file at the `bin/unix2dos/` folder. I 
don't think that's a good idea to version the **unix2dos** program, so add to more lines to `.git/config` file:

{{< highlight batch "linenos=inline" >}}
bin/unix2dos/bin
bin/unix2dos/share
{{< /highlight >}}

You'll also have to change the auto-publish script, so it converts the files before committing them. 

{{< highlight batch "linenos=inline" >}}
@echo off
REM Created based on script at http://gohugo.io/tutorials/github-pages-blog/

SETLOCAL
SET PATH=%PATH%; %__CD__%unix2dos/bin/
echo %PATH%
echo "Deploying updates to GitHub..."

REM Back to root parent dir.
cd ..

REM Build the project.  If using a theme, and it is not set in config.yaml, 
REM replace by `hugo -t <yourtheme>`
hugo

REM Listing all files to be converted LF-CRLF, if necessary.
for /r public\ %%G in (*.*) do unix2dos.exe %%G

REM Go To Public folder
cd public

REM (...) - this original script part remains the same

REM Come Back
cd ../bin

ENDLOCAL
{{< /highlight >}}

Commit again *otaviokr-blog* and now you're really good to go! This is the first post about a series I'm starting to 
tell about my experiences with this blog. If you wish to know anything in more detail, let me know!
