class StartScrap
  require 'open-uri'
  def initialize
    @url="https://coinmarketcap.com/all/views/all/"
  end

  def perform
    initialize
    @name_arr=[]
    @value_arr=[]
    page = Nokogiri::HTML(open(@url))
    crypt_data_name = page.css('table#currencies-all tbody a.currency-name-container')
    crypt_data_name.each {|name| @name_arr.push(name.text)}
    crypt_data_value = page.css('table#currencies-all tbody a.price')
    crypt_data_value.each {|name| @value_arr.push(name.text)}
    save
    return
  end

  def save
    i=0
    @name_arr.each do |name|
      Cryptomon.create!(name: name, value: @value_arr[i])
      i+=1
    end
  end
end
