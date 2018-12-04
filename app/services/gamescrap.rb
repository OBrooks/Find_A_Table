require 'rubygems'
require 'nokogiri'
require 'open-uri'


class Gamescrap
    def initialize
        @page_scrap = 1
        @url = "https://www.trictrac.net/jeu-de-societe/liste/les-tops?page=#{@pagescrap}"
        @games_infos = []
    end

    def perform
        scrap_games_links(@url)
    end

    def scrap_game_infos(url_game)
        temporary_array = []
        
        page_game = Nokogiri::HTML(open(url_game))
        puts url_game
        # page_game.xpath('/html/body/div[4]/header/div/div[2]/div[1]/div/h1/a').each do |section|
        #     temporary_array << section.text
        # end

        page_game.xpath('/html/body/div[4]/div/div[2]/div[1]/div[2]').each do |section|
            temporary_array << section.content
        end
        puts temporary_array

        page_game.xpath('/html/body/div[4]/div/div[2]/div[1]/div[2]').each do |section|
            temporary_array << section.content
        end
        puts temporary_array

        

        
    end
    
    def scrap_games_links(url)
        games_urls = []
        main_page = Nokogiri::HTML(open(url))
        #html.whatinput-types-initial.whatinput-types-mouse body div#content div.row div#content-column.small-12.medium-8.large-9.columns div.items.divided.data div.item div.content a.header
        path_game = main_page.css("a.header")
        array_tempo = []
        path_game.each do |game| 
            game.each do |components|
                if components[0] == "href"
                    if components[1][0..5] == "https:"
                        scrap_game_infos(components[1])
                    end
                end
            end
        end  
    end

    
end