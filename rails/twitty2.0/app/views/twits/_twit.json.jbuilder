json.extract! twit, :id, :content, :user_id, :created_at, :updated_at
json.url twit_url(twit, format: :json)