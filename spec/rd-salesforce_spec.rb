describe Rd::Salesforce do
  describe "client" do

    let(:with_oauth) do
      { host: 'test.salesforce.com',
        oauth_token: '123MyAwesomeToken321',
        instance_url: 'http://test.salesforce.com' }
    end

    let(:with_invalid_params) do
      { with: "ERRORS", and: "NON SENSE keys and values" }
    end

    describe "configuration" do
      it "allow multiple accounts" do
        auth_client = Rd::Salesforce::Client.new with_oauth
        expect(auth_client).to be_a(Rd::Salesforce::Client)

        second_auth_client = Rd::Salesforce::Client.new with_oauth.merge(host: "serious.host.com")
        expect(second_auth_client).to be_a(Rd::Salesforce::Client)
      end
      it "validates input params" do
        expect( lambda { Rd::Salesforce::Client.new with_invalid_params }).to raise_error(ArgumentError)
      end
    end

    describe "integrates with salesforce" do
      it "new person"
      it "only valid records"
      it "only with a valid client"
    end
  end
  describe "person" do
    it "have basic attributes"
    it "validate fields"
  end
end
