class ApiBase < ActiveResource::Base
  include ActiveModel::Validations
  extend ActiveModel::Naming

  self.site = "http://localhost:3000/"

  def put(*args)
    super
  rescue ActiveResource::ResourceInvalid => e
    add_errors_to_self(e)
  end

  def post(*args)
    super
  rescue ActiveResource::ResourceInvalid => e
    add_errors_to_self(e)
  end

  def save
    new? ? create : update
  rescue ActiveResource::ResourceInvalid => e
    add_errors_to_self(e)
  end

  protected

  def add_errors_to_self(e)
    errors.clear
    error_body = ActiveSupport::JSON.decode(e.response.body)
    if error_body.is_a?(Hash)
      error_body.each_pair { |k, v| self.errors.add(k, v) }
      false
    elsif error_body.is_a?(Array)
      error_body.each{ |x| self.errors.add(x[0],x[1]) }
      false
    else
      raise e
    end
  end

end

