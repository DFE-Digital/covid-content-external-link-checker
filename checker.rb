require "yaml"
require "faraday"
require "pry"

def check(uri)
  Faraday.get(uri)
end

def icon(req)
  if req.success?
    "✅"
  else
    "❌"
  end
end

YAML
  .load(File.read('mapping.yml'))
  .each do |page, links|
    check(page).tap do |req|
      puts "#{page.ljust(203, ' ')}        #{icon(req)}"
    end

    links.each do |link|
      check(link).tap do |req|
        puts " - #{link.ljust(200, ' ')}        #{icon(req)}"
      end
    end
  end


