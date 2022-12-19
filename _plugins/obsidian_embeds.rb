class ObsidianEmbeds < Jekyll::Generator

    # function to actually generate the site
    def generate(site)
        all_notes = site.collections['notes'].docs
        all_pages = site.pages
    
        all_docs = all_notes + all_pages
    
        link_extension = !!site.config["use_html_extension"] ? '.html' : ''
        
        all_docs.each do |current_note|
            # this portion is to ensure the things we parse are not within code blocks
            in_code_block = false
            consecutive_backticks = 0

            # Split the input string into an array of lines
            lines = current_note.content.split("\n")

            # Iterate over each line in the array and transform it in place
            lines.map! do |line|
            # Check if the line starts with 3 or more consecutive backticks and is not followed by spaces
                if line =~ /^`{2,}[^`\s]*$/
                    # Check if the number of consecutive backticks on this line is greater than or equal to the recorded value, 
                    # and the backticks are the only characters on the line
                    if in_code_block && line.count("`") >= consecutive_backticks && line.strip == "`" * line.count("`")
                        # If the conditions are met, set in_code_block to false and consecutive_back_ticks to 0
                        in_code_block = false
                        consecutive_backticks = 0
                    else
                        # If in_code_block is not already true, 
                        # set it to true and record the number of consecutive backticks
                        in_code_block = true
                        consecutive_backticks = line.count("`")
                    end
                end

                if !in_code_block
                    # apply all the parser functions
                    line = parse_image_embeds(line)
                    line = parse_wikilink(line, all_docs, site, link_extension)
                end
                line    
            end

            # Join the transformed lines back into a single string
            current_note.content = lines.join("\n") 
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
        str = str.gsub(
        /(?!.*`)\[\[([^\]]+)\]\](?!`.*$)/i, # match on the remaining double-bracket links
        <<~HTML.delete("\n") # replace with this HTML (\\1 is what was inside the brackets)
            <span title='There is no note that matches this link.' class='invalid-link'>
            <span class='invalid-link-brackets'>[[</span>
            \\1
            <span class='invalid-link-brackets'>]]</span></span>
        HTML
        )

        str
    end
        
end            