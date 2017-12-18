# frozen_string_literal: true

RSpec.describe VIISP::Auth do
  it 'returns portal endpoint' do
    expect(subject.portal_endpoint).not_to be_empty
  end

  describe '.ticket' do
    before do
      stub_request(:post, //).to_return(body: File.read('spec/fixtures/ticket.xml'))
    end

    it 'gets ticket' do
      expect(subject.ticket).to eq('dfa1339f-46b6-457d-a21d-2d7680389bfd')
    end
  end

  xit 'gets identity' do
    identity = subject.identity(ticket: '')
    File.write('identity.xml', identity.to_xml)
    p identity.to_xml
  end
end
