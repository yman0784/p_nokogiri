require 'open-uri'
require 'nokogiri'

namespace :scrape do

  desc 'finderショートカット取得'
  task :scut => :environment do
    url = "https://style.potepan.com/"
    charset = nil
    html = open(url) do |f|
      charset = f.charset
      f.read
    end
    
    page = Nokogiri::HTML.parse(html, nil, charset)
    
    p page.search("title").text
  end
end
