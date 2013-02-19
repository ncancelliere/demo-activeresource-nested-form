class Contact < ApiBase

  class Email < ApiBase
    attr_accessor :attributes

    def initialize(attributes={})
      @attributes = attributes.present? ? attributes.stringify_keys : { 'address' => nil }
    end
  end

  class Address < ApiBase
    attr_accessor :attributes

    def initialize(attributes={})
      @attributes = attributes.present? ? attributes.stringify_keys : default_attributes
    end

    def city_state
      [city, state].join(", ").upcase
    end

    private

    def default_attributes
      { "city"       => nil,
        "state"      => nil,
        "street_1"   => nil,
        "street_2"   => nil,
        "zip"        => nil }
    end

  end

end