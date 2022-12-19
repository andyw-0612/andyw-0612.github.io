class ObsidianMarkdown < Jekyll::Generator
    def generate(site)
        all_notes = site.collections['notes'].docs
        all_pages = site.pages
    
        all_docs = all_notes + all_pages
    
        link_extension = !!site.config["use_html_extension"] ? '.html' : ''
        callout(all_docs)
        
    end

    def callout(doc)
        # convert obsidian callouts like "[!Info]" to display as callouts in html
        for current_note in doc do
            # Capture everything starting with ">" and ending with a newline that does not start with ">"
            current_note.content.gsub!(/^>(.*?)\n(?!>)/m) do |matched_text|
                # Check if the first line starts with ">[!" and "]"
                if matched_text =~ /^>\s*\[!(.*?)\]\s*$/
                    # Replace the first line with the text between "[!" and "]" wrapped in div tags
                    matched_text.sub!(/^>\s*\[!(.*?)\]\s*\n/, "> <div class='callout-title'>#{$1}</div> \n")
                    # Add "{: .callout}" to the end of the matched text
                    matched_text << ("{: .callout}")
                
                    # Add a new line at the beginning and end of the matched text
                    matched_text.prepend("\n")
                    matched_text << "\n"

                end
            
                # Return the modified matched text
                matched_text
            end
        end

    end
      
    
end