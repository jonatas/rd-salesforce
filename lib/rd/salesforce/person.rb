require 'active_model'
require 'active_support/core_ext'
require 'validate_url'

module Rd
  module Salesforce

    ##
    # Basic structure to handle a contact.
    # It stores and validates basic person info and +upload_to_salesforce!+
    #

    class Person
      include ActiveModel::Model
      include ActiveModel::Validations


       cattr_accessor :translate

       self.translate = {
          :first_name => "FirstName",
          :last_name => "LastName",
          :email => "Email",
          :company => "Company",
          :website => "Website",
          :job_title => "Title",
          :phone => "Phone"
      }



      attr_accessor :first_name, :last_name, :email, :company, :job_title, :phone, :website
      attr_accessor :salesforce_id


      validates :first_name, :last_name, :email, presence: true
      validates :email,  format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
      validates :first_name, :phone, length: {maximum: 40}
      validates :last_name, :job_title, :email, length: {maximum: 80}
      validates :company, length: {maximum: 50}
      validates :website, url: {allow_nil: true}, length: {maximum: 255}

      ##
      # Uploads current person to salesforce.
      #
      # Raises ArgumentError if the +client+ is nil or client is invalid
      # Raises StandardError if the current instance is invalid

      def upload_to_salesforce!(client)
        raise ArgumentError.new("client is nil") if not client
        raise ArgumentError.new("client is invalid: #{client.inspect}") if not client.valid?
        raise ArgumentError.new("client does not respond to :save_lead method. client: #{client.inspect}") if not client.respond_to? :save_lead

        client.save_lead self
      end

      ##
      # Translates person fields to salesforce Lead attributes.
      # see more about Lead object at: https://www.salesforce.com/developer/docs/api/Content/sforce_api_objects_lead.htm

      def translate_attributes
        info = {}
        translate.each do |attribute_name, label|
          info[label] = send(attribute_name)
        end
        info
      end
    end
  end
end
