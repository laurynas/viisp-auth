RSpec.describe VIISP::Auth do
  it 'has a version number' do
    expect(VIISP::Auth::VERSION).not_to be nil
  end

  describe '.ticket' do
    subject { described_class.ticket }

    it 'gets ticket' do
      expect(subject).not_to be_empty
    end
  end
end
