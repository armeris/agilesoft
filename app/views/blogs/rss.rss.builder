xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Agilesoft"
    xml.description "Blog sobre desarrollo"
    xml.link root_path

    for post in @posts
      xml.item do
        xml.title post.title
        text = post.content
        lastIndex = text.rindex /\n/
        if !lastIndex
          lastIndex = text.rindex /\./
        end
        if lastIndex and lastIndex > 0
          text = text[0..lastIndex]
        end
        xml.description text
        xml.pubDate post.created_at.to_s(:rfc822)
        xml.link posts_path(:post_id => post)
        xml.guid posts_path(:post_id => post)
      end
    end
  end
end
