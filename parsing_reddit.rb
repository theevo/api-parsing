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

### MAIN

reddit_hash = JSON.parse(RestClient.get('http://reddit.com/.json'))
story_array = reddit_hash["data"]["children"]

story_array.each do |story_hash|
  if !over_18?(story_hash)
    puts "\n<h1>#{get_title(story_hash)}</h1>"
    puts "<a href=\"#{get_url(story_hash)}\"></a>"
    puts "<p>#{get_ups(story_hash)}</p>"
    puts "<p>#{get_downs(story_hash)}</p>"
    puts "<img src=\"#{get_image(story_hash)}\"/>"
  end
end

# binding.pry
