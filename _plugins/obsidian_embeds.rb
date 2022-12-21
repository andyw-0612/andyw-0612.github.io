require 'nokogiri'
require "liquid"

class ObsidianEmbeds < Jekyll::Generator
    # the plugin will be executed last since it converts markdown to html
    priority :lowest

    # function to actually generate the site
    def generate(site)
        all_notes = site.collections['notes'].docs
        all_pages = site.pages
    
        all_docs = all_notes + all_pages
    
        link_extension = !!site.config["use_html_extension"] ? '.html' : ''

        # initialize a jekyll parser
        parser = Jekyll::Converters::Markdown.new(site.config)
        
        all_docs.each do |current_note|
            # if the file is a style sheet, ignore it and move on
            current_note.url.end_with?(".css") ? next : 

            # get all the wikilinks, replace the pipe operator with a replacement character
            # this prevents the parser from converting them to tables
            current_note.content.gsub!(/\[\[([^\]]+)\]\]/) do |match|
                match.gsub("|", "�")
            end

            # initialize a liquid parser
            template = Liquid::Template.parse(current_note.content)
            # parse liquid
            current_note.content = template.render(site.site_payload)
            # parse html
            parsed_html = parser.convert(current_note.content)

            # convert all replacement character back to pipes
            parsed_html.gsub!(/\[\[([^\]]+)\]\]/) do |match|
                match.gsub("�", "|")
            end

            # convert to nokogiri doc 
            nokogiri_doc = Nokogiri::HTML.fragment(parsed_html)

            # get all the code nodes
            code_nodes = nokogiri_doc.css("code")
            # set everything inside code to nothing and store their content in a seperate array
            code_content = []
            # loop through every code tag and append their content to code_content
            code_nodes.each do |code_|
                code_content << code_.inner_html
                code_.inner_html = ""
            end

            # parse wikilinks and image embeds
            nokogiri_doc.inner_html = parse_image_embeds(nokogiri_doc.inner_html)
            nokogiri_doc.inner_html = parse_wikilink(nokogiri_doc.inner_html, all_docs, site, link_extension)

            # get all the code nodes
            code_nodes = nokogiri_doc.css("code")
            # loop through every code tag and put their content back
            code_nodes.each_with_index do |code_, idx|
                code_.inner_html = code_content[idx]
            end
            
            # add raw to it so jekyll's liqiud parser will not parse the document
            current_note.content = "{% raw %}" + nokogiri_doc.inner_html + "{% endraw %}"

        end
    end

    # function to parse image embeds
    def parse_image_embeds(str)
        # Define the regex pattern to match everything between "![[" and "]]"
        # this is for image embeds        
        pattern = /!\[\[(.*?.*)\]\]/

        matched_img_list = str.scan(pattern)

        if matched_img_list
            matched_img_list.each do |matched_img|
                # duplicate the string so original_img will not be pointing to matched_img[0]
                original_img = matched_img[0].dup
                # modify it so regex will match the '.'
                matched_img[0].gsub!(/\./, "\\.")
                str.sub!(
                    /!\[\[(.*#{matched_img[0]}.*)\]\]/i,
                    "<img src='#{original_img}' alt='Image Not Found'>"
                )
            end
        end
        # need the return statement
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
                /\[\[#{note_title_regexp_pattern}\|(.+?)(?=\])\]\]/i,
                anchor_tag
            )
    
            # Replace double-bracketed links with label using note filename
            # [[cats|this is a link to the note about cats]]
            str.gsub!(
                /\[\[#{title_from_data}\|(.+?)(?=\])\]\]/i,
                anchor_tag
            )
    
            # Replace double-bracketed links using note title
            # [[a note about cats]]
            str.gsub!(
                /\[\[(#{title_from_data})\]\]/i,
                anchor_tag
            )
    
            # Replace double-bracketed links using note filename
            # [[cats]]
            str.gsub!(
                /\[\[(#{note_title_regexp_pattern})\]\]/i,
                anchor_tag
            )
        end
    
        # At this point, all remaining double-bracket-wrapped words are
        # pointing to non-existing pages, so let's turn them into disabled
        # links by greying them out and changing the cursor
        str.gsub!(
        /\[\[([^\]]+)\]\]/i, # match on the remaining double-bracket links
        <<~HTML.delete("\n") # replace with this HTML (\\1 is what was inside the brackets)
            <span title='There is no note that matches this link.' class='invalid-link'>
            <span class='invalid-link-brackets'>[[</span>
            \\1
            <span class='invalid-link-brackets'>]]</span></span>
        HTML
        )
        # need the return statement 
        str
    end
        
end            