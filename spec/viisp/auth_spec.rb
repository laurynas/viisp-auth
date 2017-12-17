# frozen_string_literal: true

RSpec.describe VIISP::Auth do
  it 'returns portal endpoint' do
    expect(subject.portal_endpoint).not_to be_empty
  end

  it 'gets ticket' do
    expect(subject.ticket).not_to be_empty
  end

  xit 'gets identity' do
    identity = subject.identity(ticket: '')
    File.write('identity.xml', identity.to_xml)
    p identity.to_xml
  end
end
