describe Rd::Salesforce do

  let(:valid_attributes) do
    { first_name: "Jônatas",
      last_name: "Paganini",
      email: "jonatasdp@gmail.com",
      company: nil,
      job_title: "Developer",
      phone: "+55 4699117879",
      website: "http://ideia.me" }
  end

  let(:with_oauth) do
    { host: 'test.salesforce.com',
      oauth_token: '123MyAwesomeToken321',
      instance_url: 'http://test.salesforce.com' }
  end

  let(:with_invalid_params) do
    { with: "ERRORS", and: "NON SENSE keys and values" }
  end

  let(:person){ Rd::Salesforce::Person.new valid_attributes }
  let(:auth_client) { Rd::Salesforce::Client.new with_oauth }

  describe "client" do



    describe "configuration" do
      it "allow multiple accounts" do
        expect(auth_client).to be_a(Rd::Salesforce::Client)

        second_auth_client = Rd::Salesforce::Client.new with_oauth.merge(host: "serious.host.com")
        expect(second_auth_client).to be_a(Rd::Salesforce::Client)
      end
      it "validates input params" do
        expect( lambda { Rd::Salesforce::Client.new with_invalid_params }).to raise_error(ArgumentError)
      end
    end

  end
  describe "person" do
    describe "integrates with salesforce" do
      it "new person" do
        expect(person).to be_valid
      end
      it "only valid records" do
        invalid_person = Rd::Salesforce::Person.new {}
        expect(invalid_person).to_not be_valid
      end
      it "uploads returns true if the person is valid" do
        expect(auth_client).to receive(:create_lead).with(person)
        expect(person.upload_to_salesforce! auth_client)
      end
      it "do not uploads an invalid person" do
        expect(
          lambda do 
            expect(person).to receive(:valid?).and_return(false)
            person.upload_to_salesforce! auth_client
          end
        ).to raise_error(ArgumentError)
      end
      it "do not uploads with invalid client" do
        expect(
          lambda do
            person.upload_to_salesforce! nil
          end
        ).to raise_error ArgumentError
      end
    end
    it "has basic attributes" do
      valid_attributes.each do |attr, expected_value|
        expect(person.send(attr)).to eql(expected_value)
      end
    end
    describe "know translate attributes" do
      let (:translated_attributes) { person.translate_attributes }
      it "converts job_title to Title" do
        expect(translated_attributes).to have_key("Title")
      end
      it "uses camelized keys for all others fields" do
        expected_keys = [ "First Name", "Last Name", "Email", "Phone", "Website", "Company"]
        expected_keys.each do |expected_key|
          expect(translated_attributes).to have_key expected_key
        end
      end
    end
    it "validate field size"
    it "translate data with the Rd::Salesforce::Person#translate"
    it "uploading the object to " do
      expect(person).to respond_to(:upload_to_salesforce!)
    end
  end
end
