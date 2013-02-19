class ApplicationController < ActionController::Base

  before_filter :set_locale

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options(options={})
    logger.debug "default_url_options is passed options: #{options.inspect}\n"
    { :locale => I18n.locale }
  end

  def sanitize_nested_params(params)
    # we strip off '0' from { '0' => { :id => '1', :foo => '234'}}
    filter_params = params.select{ |k,v| k =~ /_attributes$/ }
    filter_params.each_pair do |k,v|
      filter_params[k] = v.values
    end
    params.merge(filter_params)
  end

end
