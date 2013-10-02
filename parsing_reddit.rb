require 'json'
require 'rest_client'
require 'pry'

# reddit_hash["data"]["children"][10]["data"]["title"]


def get_title(x)
  x["data"]["title"]
end

def get_url(story_hash)
  story_hash["data"]["url"]
end

def get_ups(story_hash)
  story_hash["data"]["ups"]
end

def get_downs(story_hash)
  story_hash["data"]["downs"]
end

def over_18?(story_hash)
  story_hash["data"]["over_18"]
end

def over_18?(story_hash)
  story_hash["data"]["over_18"]
end

def get_image(story_hash)
  if story_hash["data"]["media"] == nil
    "#"
  else
    story_hash["data"]["media"]["oembed"]["thumbnail_url"]
  end
end

def make_story(story_hash)
  "<li>
  <a href=\"#{get_url(story_hash)}\">
  <h1>#{get_title(story_hash)}</h1>
  <img src=\"#{get_image(story_hash)}\"/>
  <h4>Upvotes:</h4>
  <p>#{get_ups(story_hash)}</p>
  <h4>Downvotes:</h4>
  <p>#{get_downs(story_hash)}</p>
  </a>
  </li>
  "
end

def make_html(story_array)
  beginning_html = "
  <html>
  <head>
  </head>
  <body>
  <ul>"
  ending_html = "
  </ul>
  </body>
  </html>"

  body_html = ""

  story_array.each do |story_hash|
    if !over_18?(story_hash)
      body_html << make_story(story_hash)
    end
  end
  
  beginning_html + body_html + ending_html
end

### MAIN

reddit_hash = JSON.parse(RestClient.get('http://reddit.com/.json'))
story_array = reddit_hash["data"]["children"]

filename = "reddit.html"
File.open(filename, "w+") {|f| f.write(make_html(story_array)) }
