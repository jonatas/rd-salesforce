require 'restforce'

module Rd
  module Salesforce
    class Client
      VALID_PARAMS = %i(oauth_token host instance_url)
      def initialize params
        raise ArgumentError.new("Invalid Params: #{params.inspect} not in #{VALID_PARAMS.inspect}") if not valid_params? params
        @client = Restforce.new(params)
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
