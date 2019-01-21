require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

class Gamescrap
    def initialize
        @url = "https://www.trictrac.net/jeu-de-societe/liste/les-tops?page=1"
        @games_infos = []
    end

    def perform
        if Game.first.nil?
            scrap_games_links(@url)
        end
    end

    def scrap_game_infos(url_game)
        temporary_array = []
        
        page_game = Nokogiri::HTML(open(url_game))

        #Title
        if page_game.xpath('/html/body/div[4]/header/div/div[2]/div[1]/div/h1/a') == nil
            temporary_array << 'Information indisponible'
            puts "dommage"
        else
            page_game.xpath('/html/body/div[4]/header/div/div[2]/div[1]/div/h1/a').each do |section|
                temporary_array << section.text
            end
        end

        #Description
         c=0
         if page_game.css('div.column.medium-7') == nil
            temporary_array << 'Information indisponible'
            puts "dommage"
         else
            page_game.css('div.column.medium-7').each do |section|
                if c == 0
                split_array = section.content.to_s.split(" ")
                join_array = split_array.join(" ") 
                    if join_array[0..17].to_s == "Description du jeu"
                        join_array = join_array[18..-1]
                    end
                temporary_array << join_array
                break
                end 
            end
        end
        
        #Image
        if page_game.css('div.medium-3.columns.image-limited.image-wrapper img') == nil
            temporary_array << 'Information indisponible'
            puts "dommage"
        else
            page_game.css('div.medium-3.columns.image-limited.image-wrapper img').each do |section|
                if section.attr('src')
                    temporary_array <<  section.attr('src')
                else
                    temporary_array << 'Information indisponible'
                end
            end
        end

        #Min & Max of players
        if page_game.css('ul.vertical.menu.columns li') == nil
            temporary_array << 'Information indisponible'
            puts "dommage"
        else
            page_game.css('ul.vertical.menu.columns li').each do |section|
                if c == 0
                    if section.content.split(" ").length == 1
                        temporary_array << section.content.split(" ")[0][0].to_i
                        temporary_array << section.content.split(" ")[0][0].to_i
                    elsif section.content.split(" ").length == 3
                        if section.content.split(" ")[0].to_i < section.content.split(" ")[2][0].to_i
                            temporary_array << section.content.split(" ")[0].to_i
                            temporary_array << section.content.split(" ")[2][0].to_i
                        else 
                            temporary_array << section.content.split(" ")[2][0].to_i
                            temporary_array << section.content.split(" ")[0].to_i
                        end
                    else 
                        temporary_array << section.content.split(" ")[1][0].to_i
                        temporary_array << section.content.split(" ")[1][0].to_i
                    end
                break
                end
            end
        end

        #Time
        if page_game.xpath('/html/body/div[4]/div/div[3]/div/ul[1]/li[3]') == nil
            temporary_array << 'Information indisponible'
        else
            page_game.xpath('/html/body/div[4]/div/div[3]/div/ul[1]/li[3]').each do |section|
                temporary_array << section.content
            end
        end

        #Category
        categories = []
        if page_game.css('.label-group a') == nil
            temporary_array << 'Information indisponible'
        else
            page_game.css('.label-group a').each do |section|
                if c == 0
                    temporary_array << section.content
                break
                end
            end
        end

        return temporary_hash_game_description = {"Title" => temporary_array[0], "Description" => temporary_array[1], "Image" => temporary_array[2], "Min" => temporary_array[3], "Max" => temporary_array[4], "Time" => temporary_array[5], "Category" => temporary_array[6]}
    end
    
    def scrap_games_links(url)
        games_urls = []
        main_page = Nokogiri::HTML(open(url))
        path_game = main_page.css("a.header")
        array_tempo = []
        path_game.each do |game| 
            game.each do |components|
                if components[0] == "href"
                    if components[1][0..5] == "https:"
                       @games_infos << scrap_game_infos(components[1])
                    end
                end
            end
        end
        print @games_infos
        puts next_page = url[-1].to_i + 1

        @games_infos.each do |game|
            if Category.first.nil?
                Category.create!(category_name: game["Category"])
            elsif Category.find_by(category_name: game["Category"])
            else
                Category.create!(category_name: game["Category"])
            end
            Game.create!(title: game["Title"], description: game["Description"], min_players: game["Min"], max_players: game["Max"], image_url: game["Image"], time: game["Time"], category_id: Category.find_by(category_name: game["Category"]).id)
        end

        @games_infos = []

        if next_page <= 50
            dynamic_url = "#{url[0..-2]}" + "#{next_page}"
            scrap_games_links(dynamic_url)
        else 
        end
    end
end