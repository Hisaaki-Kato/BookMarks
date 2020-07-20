# frozen_string_literal: true

module RecommendBooksApi
  module_function

  def post_request(documents)
    headers = { "Content-Type" => "application/json" }
    uri = URI.parse("http://api:5000/")
    response = HTTParty.post(uri, :body => documents.to_json, :headers => headers)
  end
end