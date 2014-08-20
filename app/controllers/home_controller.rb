class HomeController < ApplicationController

  require 'nokogiri'
  require 'open-uri'
  require 'csv'

  def index
    if session.has_key?("header")
      session.delete("header")
    end
    if session.has_key?("data")
      session.delete("data")
    end
  end
  def view_data
    if session.has_key?("header")
      session.delete("header")
    end
    if session.has_key?("data")
      session.delete("data")
    end
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
      session[:header] = @table_headers
      session[:data] = @selected_data
    end
  end

  def show_result
    @table_headers = session[:header]
    @selected_data = session[:data]
    respond_to do |format|
      format.html
      format.csv { send_data @selected_data.to_csv, :filename => params[:name] }
      format.xls  #{ send_data @selected_data.to_csv(col_sep: "\t"),filename: params[:name] }
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
      if a2.nil?
	info << link.text
      else
	info << link.css("#{a2}").text
      end
    end
    info
  end
end
