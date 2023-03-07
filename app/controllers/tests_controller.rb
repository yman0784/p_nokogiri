require 'mechanize'
require 'open-uri'
require 'nokogiri'

class TestsController < ApplicationController

  def index
    Test.destroy_all
  end

  def new
    @test = Test.new
  end

  def create
    @test = Test.create(test_params)
    agent = Mechanize.new
    page = agent.get('https://www.tvkingdom.jp/chart/56.action')
    @elements = page.search('.td-schedule a')
    urls = []
    @elements.each do |ele| 
      urls << ele.get_attribute(:href) 
    end
    @data = []
    urls.each do |url| 
      data = {}
      page = agent.get(url) 
      if (page.search('h1').inner_text != "Gガイド.テレビ王国")
        data[:title] = page.search('h1').inner_text
        data[:act] = page.search('/html/body/div[6]/div[1]/div[4]/p[@class="basicTxt"]').inner_text
        data[:time] = page.search('/html/body/div[6]/div[1]/div[1]/dl/dd[1]/text()').inner_text
        @data << data
      end
      # sleep (0.1)
    end
    @tv =[]
    @data.each do |d| 
      tv ={}
      if d[:act].include?("#{@test[:actor]}")
        tv[:title] = d[:title] 
        tv[:time] = d[:time] 
        tv[:act] = d[:act]
        @tv << tv
      end   
    end 
    render :search
  end
  
  def search

  end

  private
  def test_params
    params.require(:test).permit(:actor) 
  end
end

