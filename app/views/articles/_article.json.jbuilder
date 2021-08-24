json.extract! article, :id, :title, :content, :level, :genre, :created_at, :updated_at
json.url article_url(article, format: :json)
