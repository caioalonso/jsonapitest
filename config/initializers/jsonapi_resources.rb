JSONAPI.configure do |config|
  config.json_key_format = :underscored_key
  config.route_format = :dasherized_route

  config.allow_include = true
  config.allow_sort = true
  config.allow_filter = true

  config.raise_if_parameters_not_allowed = true

  config.default_paginator = :paged

  config.top_level_links_include_pagination = true

  config.default_page_size = 10
  config.maximum_page_size = 20

  config.top_level_meta_include_record_count = true
  config.top_level_meta_record_count_key = :record_count

  config.top_level_meta_include_page_count = true
  config.top_level_meta_page_count_key = :page_count

  config.use_text_errors = false

  config.exception_class_whitelist = []

  config.always_include_to_one_linkage_data = false
end