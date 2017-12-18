# frozen_string_literal: true

RSpec.describe VIISP::Auth do
  it 'returns portal endpoint' do
    expect(subject.portal_endpoint).not_to be_empty
  end

  describe '.ticket' do
    subject { described_class.ticket }

    before do
      stub_request(:post, //).to_return(body: File.read('spec/fixtures/ticket.xml'))
    end

    it 'gets ticket' do
      expect(subject).to eq('dfa1339f-46b6-457d-a21d-2d7680389bfd')
    end
  end

  describe '.identity' do
    subject { described_class.identity(ticket: 'dummy-ticket') }

    before do
      stub_request(:post, //).to_return(body: File.read('spec/fixtures/identity.xml'))
      expect(VIISP::Auth::Signing).to receive(:validate!)
    end

    it 'gets identity' do
      expect(subject).to include(
        'authentication_provider' => 'auth.lt.bank',
        'custom_data' => 'correlation-123',
        'attributes' => hash_including(
          'lt-personal-code' => 'XXXXXXXXXXX',
        ),
        'user_information' => hash_including(
          'firstName' => 'VARDENIS',
          'lastName' => 'PAVARDENIS',
        ),
        'source_data' => hash_including(
          'type' => 'BANKLINK',
          'parameters' => hash_including(
            'VK_USER' => '12345678900'
          ),
        ),
      )
    end
  end
end
