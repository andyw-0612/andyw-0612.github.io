class ObsidianEmbeds < Jekyll::Generator
    # function to actually generate the site
    def generate(site)
        all_notes = site.collections['notes'].docs
        all_pages = site.pages
    
        all_docs = all_notes + all_pages
    
        link_extension = !!site.config["use_html_extension"] ? '.html' : ''
        
        all_docs.each do |current_note|
            # anything inside {% highlight %} tags are ignored
            # first remove all spaces in the liquid tag
            if current_note.content.match?(/{%\s*highlight/) and current_note.content.match?(/{%\s*endhighlight\s*%}/)
                # remove spaces in liquid tags
                current_note.content.gsub!(/{%\s*highlight/, "{%highlight")
                current_note.content.gsub!(/{%\s*endhighlight\s*%}/, "{%endhighlight%}")
                
                excerpt = current_note.content.split("{%highlight")
                excerpt.map! do |str|
                    # if there is an ending delimiter, if not then everything is parsable
                    if str.include?("{%endhighlight%}")
                        unparasable = str.split("{%endhighlight%}")[0]
                        parasable = str.split("{%endhighlight%}")[-1]
                        # parse image and wikilinks
                        parsed = parse_wikilink(parse_image_embeds(parasable), all_docs, site, link_extension)
                        unparasable + "{% endhighlight %}" + parsed
                    else
                        # parse_wikilink and parse_image_embeds returns the modifed string
                        parse_wikilink(parse_image_embeds(str), all_docs, site, link_extension)
                    end
                end
                
                # join everything back together with {% highlight since we lost it during split
                current_note.content = excerpt.join("{% highlight")
                
            else
                # if there are no highlight tags
                parse_image_embeds(current_note.content)
                parse_wikilink(current_note.content, all_docs, site, link_extension)
            end
        end
    end

    # function to parse image embeds
    def parse_image_embeds(str)
        # Define the regex pattern to match everything between "![[" and "]]"
        # this is for image embeds        
        pattern = /(?!.*`)!\[\[(.*?.*)\]\](?!`.*$)/

        matched_img_list = str.scan(pattern)

        if matched_img_list
            matched_img_list.each do |matched_img|
                # duplicate the string so original_img will not be pointing to matched_img[0]
                original_img = matched_img[0].dup
                # modify it so regex will match the '.'
                matched_img[0].gsub!(/\./, "\\.")
                str.sub!(
                    /^(?!.*`)!\[\[(.*#{matched_img[0]}.*)\]\](?!`.*$)/,
                    "<img src='#{original_img}'>"
                )
            end
        end
        # need the return statement for documents with "{%highlight%}", see above code
        str
    end

    # function to pase wikilinks
    def parse_wikilink(str, all_docs, site, link_extension)
        all_docs.each do |note_potentially_linked_to|
            note_title_regexp_pattern = Regexp.escape(
                File.basename(
                note_potentially_linked_to.basename,
                File.extname(note_potentially_linked_to.basename)
                )
            ).gsub('\_', '[ _]').gsub('\-', '[ -]').capitalize
    
            title_from_data = note_potentially_linked_to.data['title']
            if title_from_data
                title_from_data = Regexp.escape(title_from_data)
            end
    
            new_href = "#{site.baseurl}#{note_potentially_linked_to.url}#{link_extension}"
            anchor_tag = "<a class='internal-link' href='#{new_href}'>\\1</a>"
    
            # Replace double-bracketed links with label using note title
            # [[A note about cats|this is a link to the note about cats]]
            str.gsub!(
                /(?!.*`)\[\[#{note_title_regexp_pattern}\|(.+?)(?=\])\]\](?!`.*$)/i,
                anchor_tag
            )
    
            # Replace double-bracketed links with label using note filename
            # [[cats|this is a link to the note about cats]]
            str.gsub!(
                /(?!.*`)\[\[#{title_from_data}\|(.+?)(?=\])\]\](?!`.*$)/i,
                anchor_tag
            )
    
            # Replace double-bracketed links using note title
            # [[a note about cats]]
            str.gsub!(
                /(?!.*`)\[\[(#{title_from_data})\]\](?!`.*$)/i,
                anchor_tag
            )
    
            # Replace double-bracketed links using note filename
            # [[cats]]
            str.gsub!(
                /(?!.*`)\[\[(#{note_title_regexp_pattern})\]\](?!`.*$)/i,
                anchor_tag
            )
        end
    
        # At this point, all remaining double-bracket-wrapped words are
        # pointing to non-existing pages, so let's turn them into disabled
        # links by greying them out and changing the cursor
        str.gsub!(
        /(?!.*`)\[\[([^\]]+)\]\](?!`.*$)/i, # match on the remaining double-bracket links
        <<~HTML.delete("\n") # replace with this HTML (\\1 is what was inside the brackets)
            <span title='There is no note that matches this link.' class='invalid-link'>
            <span class='invalid-link-brackets'>[[</span>
            \\1
            <span class='invalid-link-brackets'>]]</span></span>
        HTML
        )
        # need the return statement for documents with "{%highlight%}", see above code
        str
    end
        
end            