# otaviokr-blog

A repository of thoughts, ideas, dreams and comments...

### Related Projects

This repository is related to 2 other repositories: [otaviokr.github.io](#) and [tabula-rasa](#). This section will 
explain more how these 3 repositories are entwined.

As you know, this repository is the source code of my own blog that is hosted at 
[http://otaviokr.github.io](http://otaviokr.github.io). All the files in that repository is generated in this 
repository (more specifically, in the `/public` folder) but **otaviokr-blog** is not really dependent of 
**otaviokr.github.io** - actually, you'll notice that `/public` is defined in `.gitignore` to avoid mixing the source 
code and the website itself.

On the other hand, [tabula-rasa]() is my own Hugo theme, so it has its own repository - that way, I can improve the 
theme without having to modify my blog look'n'feel. Because a website must have a theme, this repository depends on the 
tabula-rasa repository, and, because of that, I set the tabula-rasa repository as a subtree repository and now you have 
a few more commands to have the project set up correctly:

To update the tabula-rasa project:

```
git pull -s subtree themes/tabula-rasa master
```
