require 'restforce'

module Rd
  module Salesforce
    class Client
      VALID_PARAMS = %i(oauth_token host instance_url)
      def initialize params
        raise ArgumentError.new("Invalid Params: #{params.inspect} not in #{VALID_PARAMS.inspect}") if not valid_params? params
        @client = Restforce.new(params)
      end

      def create_lead(person)
        if not person.valid?
          raise ArgumentError.new("can't upload an invalid record to sales force. person is invalid: #{person.inspect}\n   #{person.errors.inspect}") 
        end
        @client.create!("Lead", person.translate_attributes)
      end

      def valid?
        not @client.nil?
      end

      private

        def valid_params? params
          return false if not params or not params.is_a? Hash
          params.each do |key,value|
            return false if not VALID_PARAMS.include?(key)
          end
          true
        end
    end
  end
end
