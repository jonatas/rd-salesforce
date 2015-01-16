require_relative "./spec_shared_behaviour"
describe Rd::Salesforce::Client do

  include_context "shared behaviour"

  describe "configuration" do
    it "allow multiple accounts" do
      expect(auth_client).to be_a(Rd::Salesforce::Client)

      second_auth_client = Rd::Salesforce::Client.new with_oauth.merge(host: "serious.host.com")
      expect(second_auth_client).to be_a(Rd::Salesforce::Client)
    end
    it "validates input params" do
      expect(
        lambda {
          invalid_keys = { with: "ERRORS", and: "NON SENSE keys and values" }
          Rd::Salesforce::Client.new invalid_keys
        }
      ).to raise_error(ArgumentError)
    end
    it "can save a lead" do
      expect(auth_client).to be_respond_to :save_lead
    end

  end
end
