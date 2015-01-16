require_relative "spec_shared_behaviour"
describe Rd::Salesforce::Person do

  include_context "shared behaviour"

  let(:person){ Rd::Salesforce::Person.new valid_person_attributes }
  let(:auth_client) { Rd::Salesforce::Client.new with_oauth }

  describe "integrates with salesforce" do
    it "new person" do
      expect(person).to be_valid
    end
    it "only valid records" do
      invalid_person = Rd::Salesforce::Person.new {}
      expect(invalid_person).to_not be_valid
    end
    it "uploads returns true if the person is valid" do
      expect(auth_client).to receive(:save_lead).with(person)
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
    valid_person_attributes.each do |attr, expected_value|
      expect(person.send(attr)).to eql(expected_value)
    end
  end
  describe "know translate attributes" do
    let (:translated_attributes) { person.translate_attributes }
    it "converts job_title to Title" do
      expect(translated_attributes).to have_key("Title")
    end
    it "uses camelized keys for all others fields" do
      expected_keys = Rd::Salesforce::Person.translate.values
      expected_keys.each do |expected_key|
        expect(translated_attributes).to have_key expected_key
      end
    end
  end
  describe "validations" do
    it "validate maximum size of each field" do
      invalid_attributes = {}
      valid_person_attributes.each do |name, value|
        invalid_attributes[name] = value * 50 if value
      end
      invalid_person = Rd::Salesforce::Person.new invalid_attributes
      expect(invalid_person).to_not be_valid
      valid_person_attributes.each do |name, value|
          expect(invalid_person.errors).to have_key name if value
      end
    end
  end
  describe "translations" do
    it "can be overrided"  do
      Rd::Salesforce::Person.translate = {:email => "FirstName"}
      attributes = person.translate_attributes
      expect(attributes).to eql("FirstName" => "jonatasdp@gmail.com")
    end
  end
  it "uploading the object to " do
    expect(person).to respond_to(:upload_to_salesforce!)
  end
end
