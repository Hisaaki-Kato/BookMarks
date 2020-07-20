# frozen_string_literal: true

module GoogleBooksApi
  module_function

  def get_results(keyword, num=3)
    keyword = URI.encode_www_form_component(keyword)
    url = "https://www.googleapis.com/books/v1/volumes?q=#{keyword}&maxResults=#{num}"
    response = HTTParty.get(url)

    if response['items'].present?
      count = response['items'].length
      results = Array.new(count).map { Array.new(4) }
      count.times do |x|
        results[x][0] = response.dig('items', x, 'volumeInfo', 'title')
        results[x][1] = response.dig('items', x, 'volumeInfo', 'imageLinks', 'thumbnail')
        results[x][1] = if results[x][1].nil?
                          '/no-image.png'
                        else
                          results[x][1].gsub!('http', 'https')
                        end
        results[x][2] = response.dig('items', x, 'volumeInfo', 'authors')
        results[x][2] = results[x][2].join(',') if results[x][2] # 複数著者をカンマで区切る
      end
    end
    results
  end
end
