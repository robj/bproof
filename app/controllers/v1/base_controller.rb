class V1::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token  
  skip_before_filter :step_through_signup
  skip_before_filter :ensure_at_least_one_profile_image  

  wrap_parameters format: [:json]
  ##, exclude: [:auth_token]



 #http://jimbocortes.com/post/33940132243/adding-api-pagination-in-the-response-header
 # this gives me last and first, unlike api-pagination

 # above reference has 2 errors,  '>' after rel , and Links instead of Link

 protected
  def set_pagination(name, options = {})

    scope = instance_variable_get("@#{name}")
    request_params = request.query_parameters
    url_without_params = request.original_url.slice(0..(request.original_url.index("?")-1)) unless request_params.empty?
    url_without_params ||= request.original_url
 
    page = {}
    page[:first] = 1 if scope.total_pages > 1 && !scope.first_page?
    page[:last] = scope.total_pages  if scope.total_pages > 1 && !scope.last_page?
    page[:next] = scope.current_page + 1 unless scope.last_page?
    page[:prev] = scope.current_page - 1 unless scope.first_page?
 
    pagination_links = []
    page.each do |k,v|
      new_request_hash= request_params.merge({:page => v})
      pagination_links << "<#{url_without_params}?#{new_request_hash.to_param}>;rel=\"#{k}\""
    end
    headers[:Link] = pagination_links.join(",")
  end


end
