json.array!(@events) do |event|
  json.extract! event, :id, :title, :time
  json.url event_url(event, format: :json)
end
