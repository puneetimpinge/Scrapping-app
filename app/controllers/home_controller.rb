class HomeController < ApplicationController

  require 'nokogiri'
  require 'open-uri'

  def index

  end
  def view_data
    if params.has_key?('url')
      doc = Nokogiri::HTML(open(params[:url]))
      name_selector = JSON.parse(params[:row_data])
      @table_headers = []
      @selected_data = []
      name_selector.each do |obj|
        selector = obj["selector"]
        @selected_data << get_data(doc, selector)
        @table_headers << obj["name"]
      end
    end
  end
  private

  def get_data(doc,selector)
    info = []
    #doc.xpath("//#{params[:data][:type]}").each do |link|
    #  info << link.content.to_s
    #end
    a1 = selector.split(',')[0]
    a2 = selector.split(',')[1]
    doc.css("#{a1}").each do |link|
      info << link.css("#{a2}").text
    end
    info
  end
end