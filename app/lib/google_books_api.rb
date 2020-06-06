module GoogleBooksApi
  extend self
  def get_results(keyword)
    url = URI.encode("https://www.googleapis.com/books/v1/volumes?q=#{keyword}&maxResults=10")
    response = HTTParty.get(url)

    if response["items"].present?
      count = response["items"].length
      results = Array.new(count).map{Array.new(4)}
      count.times do |x|
        results[x][0] = response.dig("items", x, "volumeInfo", "title")
        results[x][1] = response.dig("items", x, "volumeInfo", "imageLinks", "thumbnail")
        results[x][2] = response.dig("items", x, "volumeInfo", "authors")
        results[x][2] = results[x][2].join(',') if results[x][2] #複数著者をカンマで区切る
      end
    end
    return results
  end
end