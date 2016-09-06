module ProtectedUpdate

  extend ActiveSupport::Concern

  included do
    has_many :past_attributes, as: :tuple
    @@protected_attributes = []

    def protected_update(key, value)
      unless @@protected_attributes.include?(key)
        self.update_attribute(key, value)
        return
      end
      if past_attributes.find_by(key:key, value:value).nil?
        self.past_attributes.create!(key:key, value:value)
        self.update_attribute(key, value)
      end
    end
  end

  class_methods do
    def protect_attributes(*keys)
      @@protected_attributes += keys
    end
  end

end