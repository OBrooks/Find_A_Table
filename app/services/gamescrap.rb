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
        #puts url_game

        #Title
        page_game.xpath('/html/body/div[4]/header/div/div[2]/div[1]/div/h1/a').each do |section|
            temporary_array << section.text
        end

        # #Description
         c=0
        page_game.css('div.column.medium-7').each do |section|
            if c == 0
                temporary_array << section.content
                puts section.content
            break
            end 
        end

        #Image
        page_game.css('div.medium-3.columns.image-limited.image-wrapper img').each do |section|
            
            temporary_array <<  section.attr('src')
        end

        #Min & Max of players
        page_game.css('ul.vertical.menu.columns li').each do |section|
            if c == 0
                #Min
                temporary_array << section.content.split(" ")[0].to_i
                #Max
                temporary_array << section.content.split(" ")[2][0].to_i
            break
            end
        end

        #Time
        page_game.xpath('/html/body/div[4]/div/div[3]/div/ul[1]/li[3]').each do |section|
            temporary_array << section.content
            puts section.content
        end

        #Category
        categories = []
        page_game.css('.label-group a').each do |section|
            if c == 0
                temporary_array << section.content
            break
            end
        end

        temporary_hash_game_description = {"Title" => temporary_array[0], "Description" => temporary_array[1], "Image" => temporary_array[2], "MinAge" => temporary_array[3], "MaxAge" => temporary_array[4], "Time" => temporary_array[5], "Categories" => temporary_array[6]}
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