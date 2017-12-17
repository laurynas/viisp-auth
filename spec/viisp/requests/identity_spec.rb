# frozen_string_literal: true

RSpec.describe VIISP::Auth::Requests::Identity, '#build' do
  subject { described_class.new(ticket: ticket).build.to_xml }

  let(:ticket) { 'test-ticket' }

  it 'builds request' do
    expect(subject).to include(ticket)
    expect(subject).to include('ds:Signature')
    expect(subject).to include('soapenv:Envelope')
  end
end
