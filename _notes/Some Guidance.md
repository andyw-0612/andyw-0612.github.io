---
---
<head>
Information here and there about the notes and the website
</head>

<hr>
## Table of Contents
{:.no_toc .toc-heading}
1. 
{:toc}
<hr>

## Basic Information

This site is created using the static site generater [Jekyll](https://jekyllrb.com), modified from the [Jekyll Digital Garden Theme](https://github.com/maximevaillancourt/digital-garden-jekyll-template), inspired by the [Obsidian Help Page](https://help.obsidian.md) and the Jekyll [Just the Docs](https://github.com/just-the-docs/just-the-docs) theme. 

![[homepage-sc.png]]

This will be a place where I put down my random thoughts and notes on the online courses I stroll through from time to time. This site is hosted through Github Pages and Github Actions. Due to Github not being compatible with Jekyll sites that have custom plugins, the site is pushed onto the `master` branch on Github but built through a [workflow](https://github.com/andyw-0612/andyw-0612.github.io/blob/master/.github/workflows/main.yml) to the `gh-pages` branch as static `html`, `css`, and `javascript` files, then the Github pages is built from that branch as opposed to the usual `master` branch. 

A lot of customization went into building the website and I'll try my best to sort through and document everything for one day if my future self wants to come back.

### Running the Site Locally

If you have [Ruby](https://www.ruby-lang.org/en/) and [Bundler](https://bundler.io) installed, running the site is as simple as running the following commands. 
```shell
bundle install
bundle exec jekyll serve
```

> [!Info]
>  For a more detailed tutorial on running Jekyll sites locally, visit the official Github Pages Documentation [here](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll).
> 

## File Structure

* `/_layouts` : This folder consists of the website layout for different types of pages as `html` files. 