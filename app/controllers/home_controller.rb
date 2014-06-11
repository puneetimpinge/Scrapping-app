class HomeController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

def index
# Get a Nokogiri::HTML::Document for the page we’re interested in...

if params.has_key?('data')
#doc = Nokogiri::HTML(open('http://www.google.com/search?q=sparklemotion'))
doc = Nokogiri::HTML(open(params[:data][:link]))
# Do funky things with it using Nokogiri::XML::Node methods...

####
# Search for nodes by css
#   doc.css('h3.r a').each do |link|
#     puts link.content
#   end

####
# Search for nodes by xpath
#   doc.xpath('//h3/a').each do |link|
#     puts link.content
#   end
  @info = []
  doc.xpath("//#{params[:data][:type]}").each do |link|
    @info << link.content.to_s
  end
  #redirect_to :back
####
# Or mix and match.
#   doc.search('h3.r a.l', '//h3/a').each do |link|
#     puts link.content
#   end
end
end
end