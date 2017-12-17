# frozen_string_literal: true

RSpec.describe VIISP::Auth::Requests::Ticket, '#build' do
  subject { described_class.new(options).build.to_xml }

  let(:options) do
    {
      pid: pid,
      providers: providers,
      attributes: attributes,
      user_information: user_information,
      postback_url: postback_url,
      custom_data: custom_data,
    }
  end

  let(:pid) { 'VSID000000000113' }
  let(:providers) { %w[auth.lt.identity.card auth.lt.bank] }
  let(:attributes) { %w[lt-personal-code] }
  let(:user_information) { %w[firstName lastName] }
  let(:postback_url) { 'https://localhost' }
  let(:custom_data) { 'correlationData' }

  it 'builds request' do
    expect(subject).to include(pid)
    expect(subject).to include(providers.last)
    expect(subject).to include(attributes.last)
    expect(subject).to include(user_information.last)
    expect(subject).to include(postback_url)
    expect(subject).to include(custom_data)
    expect(subject).to include('ds:Signature')
    expect(subject).to include('soapenv:Envelope')
  end
end
