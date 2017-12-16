# frozen_string_literal: true

RSpec.describe VIISP::Auth::Requests::Soap, '.build' do
  subject { described_class.build(body) }

  let(:request) { described_class.build(body) }

  let(:body) { '<test>1</test>' }

  it 'builds request' do
    expect(subject).to include('soapenv:Envelope')
    expect(subject).to include(body)
  end
end
