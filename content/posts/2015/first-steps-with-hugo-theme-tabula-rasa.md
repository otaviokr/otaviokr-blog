+++
date = "2015-06-19T23:24:04+02:00"
draft = false
title = "First Steps With Hugo Theme Tabula-Rasa"
description = "What you need to know to create your own theme for Hugo."
categories = [ "metablog", "hugo", "template", "tabula-rasa" ]
series = [ "Improving the Blog" ]
slug = "first-steps-with-hugo-theme-tabula-rasa"
project_url = "https://otaviokr.github.io"
toc = true

+++

# What is a *Theme*?

If you're coming from any other blogging plataform, *theme* is just another name for a *template* - but keep in mind 
that Hugo uses *template* to talk about templating functionalities. Now, that's not very helpful if you know nothing 
about other blogging plataforms, so let me elaborate a little further.

When you have a website, it's very likely that many - if not most - of you pages will have the exactly same 
look'n'feel, but with different content (in this blog, for example, notice how all post look exactly the same, with 
only the text itself being specific for each post. No imagine how much time I'd lose writing all the HTML to get 
exactly the same layout - think if I wanted to change something like the text color! Maybe you just 
[enjoy typing, but I prefer DRY solutions](https://en.wikipedia.org/wiki/Don't_repeat_yourself). 

Here's a piece of my theme Tabula-Rasa (which is being used in this website BTW):

{{< highlight html "linenos=inline" >}}
{{ partial "header.html" . }}

<div class="container">
  <div class="row">
    <div class="col-sm-3 blog-sidebar">
      {{ partial "sidebar.html" . }}
    </div>

    <div class="col-sm-8 col-sm-offset-1 blog-main">
      <section class="post">
        <header class="post-header">
          <h2 class="post-title">
            <a href="{{ .RelPermalink }}">
              {{ .Title }} {{ if .Draft }}<small>(draft)</small>{{end}}
            </a>
          </h2>
          <p>
            {{ .Render "metadata" }}
            <span class="post-date">
              <time datetime="{{ .Date.Format "2006-01-02T15:04:05Z07:00" }}">
                {{ .Date.Format "02 Jan 2006, 15:04" }}
              </time>
{{< /highlight >}}

You can check the entire code at `layouts/_default/single.html`. I won't get into any detail yet, but those familiar 
with HTML probably are scratching their heads because of those double curly brackets (**{{** and **}}**): those are 
the template directives to render another HTML page inside this one, or to retrieve this post title.

So, instead of write everything over and over again, we can define layouts and just point where the dynamic data (like 
the post text) should be placed and have the system taking care of creating the pages as designed.

>Here's a major difference between Hugo and other blogging tools: while Hugo process the posts and create all the 
pages using the layout only once, traditional plataforms - like Blogger, Wordpress and Django - will parse the 
post and use the template to generate a page only to serve it to a specific request.  

As I said in my [introductory post](/posts/2015/setting-up-your-own-free-blog), there are many themes ready for use - 
including this one! Feel free to use it and leave any feedback! - but someday you'll want to play around the theme, 
yours or not, to create from scratch, just to fix an annoying bug or even to customize it. So, I'll just put you in the 
right direction and explain how I created my [Tabula-Rasa](http://www.github.com/otaviokr/tabula-rasa).

# Can I use a template from other plataforms (e.g., Wordpress)?

Before diving in the code, let me just explain something for those that are really starting: you cannot use a Hugo 
Theme in any other plataform, nor you can get a template from other plataform (like Wordpress, Blogger, Django, Joomla, 
Drupal, etc.) to use directly on Hugo - you can salvage only the HTML/CSS/Javascript code, but you'll have to adapt all 
the templating functions, like where to put the title, the contents, authors etc. Now impossible, but be prepared for a 
lot of work.

# You only need three files...

In a nutshell, we can say that Hugo has basically 3 types of pages: **index**, **list** and **single**. The index is 
the home page where the user should land when accessing you website at root path (meaning no specific post or page); a 
list is any page that should display multiple entries logically grouped, like all articles from a specific category; 
finally, the single is used to render all blog posts. If you define all those three pages, your site will be fully 
operational.
 
However, if you check the Tabula-Rasa project, you'll notice it has more than only those 3 files, but the reason is 
very simple: remember the [DRY principle](https://en.wikipedia.org/wiki/Don't_repeat_yourself)? To avoid writing the 
headers and footers for all pages (they are the same for single and index, for example), we can split the layout in 
many file and call them as needed.

So, I suggest we start with very simple layout for each of the files - I hope you'll get excited to improve these files 
later, but for now, let's keep it as basic as possible to focus on the resources that Hugo has. Also, all files listed 
here must stored at `<blog_root_project>/themes/<theme-name>/` folder. Also, whenever I use **Tabula-Rasa** in this 
text, know that I'm just saying about *<theme_name>*, except when I'm talking about any particularities related to my 
theme. Here's the three main files:

{{< highlight html "linenos=inline" >}}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="{{ .Title }}"/>
    <meta name="author" content="{{ .Site.Author.name }}"/>
    <base href="{{ .Site.BaseURL }}/" />
    <title>{{ .Title }}</title>
    <link href="index.xml" rel="alternate" type="application/rss+xml" title="Posts" />
    <link href="posts/index.xml" rel="alternate" type="application/rss+xml" title="Posts" />
  </head>

  <body>
    {{ range where .Site.Pages "Section" "posts" }}
      <h2>
        <a href="{{ .RelPermalink }}">
          {{ .Title }} {{ if .Draft }}<i>(draft)</i>{{end}}
        </a>
      </h2>
      <p>
        <time datetime="{{ .Date.Format "2006-01-02T15:04:05Z07:00" }}">
          {{ .Date.Format "02 Jan 2006, 15:04" }}
        </time>
      </p>
      <p>{{ .Summary }}</p>
      {{ if .Truncated }}
        <p class="readmore">
          <a class="btn btn-primary" href="{{ .RelPermalink }}">
            Read more...
          </a>
        </p>
      {{ end }}
      <hr />
    {{ end }}
  </body>
</html>
{{< /highlight >}}

This is the `layouts/index.html`. I won't get any details yet, but I bet you can read the code and have an idea of 
what's going on.

{{< highlight html "linenos=inline,hl_lines=16 17 18 19 20 21 22 23 24 25 26 27" >}}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="{{ .Title }}"/>
    <meta name="author" content="{{ .Site.Author.name }}"/>
    <base href="{{ .Site.BaseURL }}/" />
    <title>{{ .Title }}</title>
    <link href="index.xml" rel="alternate" type="application/rss+xml" title="Posts" />
    <link href="posts/index.xml" rel="alternate" type="application/rss+xml" title="Posts" />
  </head>

  <body>
    <ul class="posts">
      {{ range .Data.Pages }}
        {{ if eq .Type .Section }}
          <li>
            <a href="{{ .RelPermalink }}">{{ .Title }}</a>
            <time datetime="{{ .Date.Format "2006-01-02T15:04:05Z07:00" }}">
              {{ .Date.Format "Mon, Jan 2, 2006" }}
            </time>
          </li>
        {{ end }}
      {{ end }}
    </ul>
  </body>
</html>
{{< /highlight >}}

You'll notice that only what's inside `<body>` tag has changed. After all, there's nothing special about in a list but 
a bunch of links to other pages and the header should be basically the same for all pages. We'll have a best solution 
for this issue when we talk about partials.

{{< highlight html "linenos=inline" >}}
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="{{ .Title }}"/>
    <meta name="author" content="{{ .Site.Author.name }}"/>
    <base href="{{ .Site.BaseURL }}/" />
    <title>{{ .Title }}</title>
    <link href="index.xml" rel="alternate" type="application/rss+xml" title="Posts" />
    <link href="posts/index.xml" rel="alternate" type="application/rss+xml" title="Posts" />
  </head>

  <body>
    <h2>
      <a href="{{ .RelPermalink }}">
        {{ .Title }} {{ if .Draft }}<small>(draft)</small>{{end}}
      </a>
    </h2>
    <p>
      <time datetime="{{ .Date.Format "2006-01-02T15:04:05Z07:00" }}">
        {{ .Date.Format "02 Jan 2006, 15:04" }}
      </time>
    </p>
    {{ .Content }}
  </body>
</html>
{{< /highlight >}}

Again, the only changes in the code are inside `<body>` tag. With those three files, you already have a working 
blogging, but I guess you have no idea what's actually happening, so let's dive in the code and talk about functions 
and variables. 

# ...and a handful of functions and variables

First of all, this is **not** an extensive list of all functions and variables - the best source for such thing is the 
[official Hugo website](http://gohugo.io) - [functions](http://gohugo.io/templates/functions/) and 
[variables](http://gohugo.io/templates/variables/). I'll address just what we have used on those three initial files in 
the previous section - I'm not posting the code again too, so, please refer to their listing in the previous section to 
see how these functions and variables are being used.

Many of the variables I present below will give a different value depending on the context where they are being called. 
Context is defined by the system (for example, when rendering `single.html`, the context used is the *page* that's 
being rendered, while `index.html` uses the *site* context) but you can also define the context when calling a partial, 
using the dot (`.`) notation - e.g., `{{ partials "my_partial.html" . }}`. The dot means *current context*, so if you 
use it inside a *for-loop* the dot stands for *the current page set in the loop*.

All variables and functions below are currently being used in Tabula-Rasa theme, so after studying this you should be 
able to understand everything happening in the theme - at least, at the moment I'm writing this post... maybe some new 
variables/functions will be added later, and I'm not sure I need to keep this list updated; anyway, this is certainly 
the basics and a very good start point. If you wish to know more, there's always the [Hugo website](http://gohugo.io).
 
- **.Summary**  
  This variable can only be used with a page context. Summary returns the first few lines of a post, with the Markdown 
  parsed and all necessary HTML tags inserted.
  
- **.Content**  
  This variable can only be used with a page context. This is the entire post parsed and ready to be inserted in a HTML 
  page.

- **.Date.Format "2006-01-02T15:04:05Z07:00"**  
  This variable can only be used with a page context. It displays the date defined in the post configuration, but with 
  the specific format defined with the example. This is very handy when you need to use the date for links.
  
- **.Date.Format "02 Jan 2006, 15:04"**  
  This is basically the same as the previous item, but with a different format to display the date and time.

- **.Title**  
  If context is the site (if it's used on `index.html`, for example) this is the name of site, as defined in the 
  `config.yaml` file as `title`; when used with a page as context, this is the blog post title.
  
- **.Site.Author.name**  
  Notice that we are forcing the site context here. If you look at the `config.yaml` file, you'll notice there's an 
  author section, with some variables defined (see below). To access those variables, you must use this notation.
  
  {{< highlight yaml "linenos=inline,hl_lines=2" >}}
  author:
    name: "Otavio Krambeck Rofatto"
    email: "rofatto@gmail.com"
  
    github: "otaviokr"
    twitter: "okrofatto"
    linkedin: "otaviorofatto"
    tag_manager: "GTM-T9L4PM"
  {{< /highlight >}}
  
- **.Site.BaseURL**  
  The `baseurl` parameter defined in the `config.yaml` configuration file. As you can see you can access any parameter 
  using `.Site.param_name` or `.Site.section.param_name`.

- **if .Draft**  
  This variable only makes sense in a page context. The function `if` is pretty obvious: check if the page is a draft.
  
- **if eq .Type .Section**  
  In the previous test, we just tested if a variable existed - or, if it's a boolean, if it exists and it is true. But 
  that's very limited. So here's a more complex test: *check if variable **Type** has the same value as variable 
  **Section***. Notice the order of the elements in the command; it's a little different than we are used to write.

- **range .Data.Pages**  
  If you're familiar with [Go](), you know `range` if how Go defines the for-loop. Here, we are going through all the 
  pages available.
  
- **range where .Data.Pages "Section" "posts"**  
 This is a more sophisticated version of `range`. This may not be very intuitive, but it reads *loop over all pages 
 which paramater **Section** is equal to **post***. This is a very power resource, and I strongly recommend to play 
 with it for some time to understand how it works. 
 

# Splitting into partials

Remember when I said to avoid writing the anything more than once and right after I presented three files with the same 
`<head>` content? So how can we avoid that, you may be wondering - and the answer is **partials**!

A *partial* is a piece of a web page that can be reused. In our example, I'll make things simple and just change 
whatever is inside `<head>` tag, but take a look at the Tabula-Rasa project and you'll see many different applications 
- not only to avoid repetition, but also to encapsulate specific parts of the layout in order to have a website easier 
to maintain.

So, remove the whole `<head>` tag from the three original files and replace them by the following code:

{{< highlight html "linenos=inline" >}}
{{ partial "header.html" . }}
{{< /highlight >}}

I believe it's easy enough to understand that `partial` is the function name to render HTML pages inside HTML pages, 
`header.html` is the file name to load (it should be stored at `layouts/partials/` folder!) and the dot (`.`) indicates 
the context to be used inside that partial - the dot indicates the current context and it is usually the case to be 
used.

Just in case you're not sure what should be removed from the three original files and saved into `header.html`, here's 
the entire code:

{{< highlight html "linenos=inline" >}}
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="{{ .Title }}"/>
  <meta name="author" content="{{ .Site.Author.name }}"/>
  <base href="{{ .Site.BaseURL }}/" />
  <title>{{ .Title }}</title>
  <link href="index.xml" rel="alternate" type="application/rss+xml" title="Posts" />
  <link href="posts/index.xml" rel="alternate" type="application/rss+xml" title="Posts" />
</head>
{{< /highlight >}}

As I said before, there's a lot of possibilities with partials. Feel free to explore and experiment and check the 
Tabula-Rasa code for inspiration. One particular case I find important enough to spend some time on it: pagination, and 
that's why I'll do a post just about that topic.

# What about that archetype?

Archetypes are models. In our case, a post is an archetype and it will always be expected to have some parameters, like 
categories, table of contents flag etc. So we create an archetype that will include all those expected fields when we 
run the command `hugo new /posts/<year>/<filename>.md` to create a new post file. I won't extend too much in this 
subject, but I believe this is all you need to know to understand why that file is in the theme. If you want to 
customize it or know more, as always, check the [official Hugo website](http://gohugo.io).
