class HomeController < ApplicationController

  require 'nokogiri'
  require 'open-uri'

  def index
    if params.has_key?('data')
      doc = Nokogiri::HTML(open(params[:data][:link]))

      @info = []

      doc.xpath("//#{params[:data][:type]}").each do |link|
        @info << link.content.to_s
      end

    end
  end
end