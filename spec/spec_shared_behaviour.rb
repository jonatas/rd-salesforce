RSpec.shared_context "shared behaviour", :a => :b do

  let(:valid_person_attributes) do
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

  let(:auth_client) { Rd::Salesforce::Client.new with_oauth }

end
