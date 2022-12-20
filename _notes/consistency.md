---
title: Consistency is key
---

Show up. Do the work. Be consistent.

Then go take a look at the [[Your first note|first note]].

The backend code is also consistent, look at these all working!

First, linking to a note like [[Your first note|this is working!]] or [[this note is not present]]

But how did I do that? Well, something like... `[[Your first note|this is working!]]`
or...
{% highlight liquid %}
[[this note is not present]]
{% endhighlight %}

But how did I do THAT?

{%raw%}
```liquid
{% highlight liquid %}
[[this note is not present]]
{% endhighlight %}
```
{%endraw%}

Now.. To show off the images `![[notes-media/image.jpg]]`
![[notes-media/image.jpg]]

And this is how..
{% highlight liquid %}
![[notes-media/image.jpg]]
{% endhighlight %}

How I did THAT...

{%raw%}
```liquid
{% highlight liquid %}
![[notes-media/image.jpg]]
{% endhighlight %}
```
{%endraw%}