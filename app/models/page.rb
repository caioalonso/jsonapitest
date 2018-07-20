require 'open-uri'

class Page < ApplicationRecord
  serialize :h1
  serialize :h2
  serialize :h3
  serialize :links
  validates :url, presence: true, url: true

  def scrape
    doc = Nokogiri::HTML(open(self.url))
    self.h1 = doc.css('h1').map { |el| el.text }
    self.h2 = doc.css('h2').map { |el| el.text }
    self.h3 = doc.css('h3').map { |el| el.text }
    self.links = doc.css('a[href]').map do |el|
      URI.join( self.url, el['href'] ).to_s
    end
  end
end
