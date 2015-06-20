# otaviokr-blog

A repository of thoughts, ideas, dreams and comments...

## Overview

This is the my blog source code. I'm using [Hugo](http://gohugo.io), a static website enging written in 
[Go](https://golang.org/) that allows web content creators to be free from database, administrative privileges and 
other ~~complicated~~ wibbly wobbly, timey wimey stuff.

This repository is highly recommended for anyone who wants to see what's behind the curtains, wants to learn more about 
Hugo or even to those who wishes to create their own website/blog. However, if you just want to check my Hugo theme, I 
suggest you check the [Tabula-Rasa repository](otaviokr/tabula-rasa), and for those that just want to have a good time 
and read something interesting, the place to go is my [blog hosted on Github Pages](http://otaviokr.github.io) - the 
website itself is also a repository and you can find it at [otaviokr.github.io](otaviokr/otaviokr.github.io).

### Related Projects

This repository is related to 2 other repositories: [otaviokr.github.io](otaviokr/otaviokr.github.io) and 
[tabula-rasa](otaviokr/tabula-rasa). This section will 
explain more how these 3 repositories are entwined.

As you know, this repository is the source code of my own blog that is hosted at 
[http://otaviokr.github.io](http://otaviokr.github.io). All the files in that repository is generated in this 
repository (more specifically, in the `/public` folder) but **otaviokr-blog** is not really dependent of 
**otaviokr.github.io** - actually, you'll notice that `/public` is defined in `.gitignore` to avoid mixing the source 
code and the website itself.

On the other hand, [tabula-rasa](otaviokr/tabula-rasa) is my own Hugo theme, so it has its own repository - that way, I 
can improve the theme without having to modify my blog look'n'feel. Because a website must have a theme, this 
repository depends on the tabula-rasa repository, and, because of that, I set the tabula-rasa repository as a subtree 
repository and now you have a few more commands to have the project set up correctly:

To update the tabula-rasa project:

```
git pull -s subtree themes/tabula-rasa master
```
