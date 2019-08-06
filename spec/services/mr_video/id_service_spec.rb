require 'rails_helper'

describe MrVideo::IdService do
  let(:service) { described_class }
  subject { service }

  describe '#encode' do
    let(:value) { 'some/cassette/directory' }
    let(:result) { service.encode(value) }
    subject { result }

    it 'should be encoded' do
      expect(result).to eq('c29tZS9jYXNzZXR0ZS9kaXJlY3Rvcnk')
    end

    it 'should be decoded back to its original value' do
      expect(service.decode(result)).to eq(value)
    end
  end

end