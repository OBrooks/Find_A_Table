require 'rubygems'
require 'nokogiri'
require 'open-uri'


class Gamescrap
    def initialize
        @page_scrap = 1
        @url = "https://www.trictrac.net/jeu-de-societe/liste/les-tops?page=#{@pagescrap}"
    end

    def perform
        save(@url)
    end

    def save(url)
        games_urls = []
        page = Nokogiri::HTML(open(url))  
        #html.whatinput-types-initial.whatinput-types-mouse body div#content div.row div#content-column.small-12.medium-8.large-9.columns div.items.divided.data div.item div.content a.header
        path_game = page.css("a.header")
        path_game.each do |game|
            game_url = game.text
            games_urls << game_url
            puts game_url
        end

        # crypto_value = []
        # path_value= page.css("a.price")
        # path_value.each do |section|
        #     crypto_value << section.text
        # end
        
        # compteur = 0
        # while compteur <= crypto_name.length
        #     Crypto.create!(crypto_name: crypto_name[compteur], crypto_value: crypto_value[compteur])
        #     compteur = compteur + 1
        # end
    end
end