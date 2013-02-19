class ApplicationController < ActionController::Base

  def sanitize_nested_params(params)
    # we strip off '0' from [{ '0' => { :id => '1', :foo => '234'}}]
    filter_params = params.select{ |k,v| k =~ /_attributes$/ }
    filter_params.each_pair do |k,v|
      filter_params[k] = v.map{ |x| x.values.first}
    end
    params.merge(filter_params)
  end

end
