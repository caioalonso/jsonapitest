class PagesController < ApplicationController
  def index
    jsonapi_render json: Page.all
  end

  def create
    page = Page.new(resource_params)
    if not page.valid?
      jsonapi_render_errors json: page, status: :unprocessable_entity
      return
    end

    begin
      page.scrape
    rescue
      errors = [{ title: 'Could not scrape the given URL', code: '101' }]
      jsonapi_render_errors json: errors, status: :unprocessable_entity
      return
    end

    if page.save
      jsonapi_render json: page, status: :created
    else
      errors = [{ title: 'Something went wrong', code: '101' }]
      jsonapi_render_errors json: errors, status: :unprocessable_entity
    end
  end
end