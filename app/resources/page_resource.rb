# app/resources/user_resource.rb
class PageResource < JSONAPI::Resource
  attributes :h1, :h2, :h3, :links, :url
end
