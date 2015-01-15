require 'restforce'

module Rd
  module Salesforce
    class Client
      def initialize params
        @client = Restforce.new(params)
      end
    end
  end
end
