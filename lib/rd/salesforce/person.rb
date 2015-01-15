require 'active_model'
require 'active_support/core_ext'
require 'validate_url'

module Rd
  module Salesforce
    class Person
      include ActiveModel::Model
      include ActiveModel::Validations


      attr_accessor :name, :last_name, :email, :company, :job_title, :phone, :website

      validates :name, :last_name, :email, presence: true
      validates :email,  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
      validates :job_title, length: {maximum: 30}
      validates :company, length: {maximum: 50}

      validates :website, :url => {:allow_nil => true}

    end
  end
end
