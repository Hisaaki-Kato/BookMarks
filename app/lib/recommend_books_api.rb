# frozen_string_literal: true

module RecommendBooksApi
  module_function

  def extract_important_words(texts_list)
    documents = { 'documents' => texts_list }
    headers = { "Content-Type" => "application/json" }
    uri = URI.parse("http://api:5000/")
    response = HTTParty.post(uri, :body => documents.to_json, :headers => headers)
    important_words = response['important_words']
  end
end