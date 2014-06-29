require 'rails_helper'

describe MrVideo::Episode do
  let(:episode_class) { MrVideo::Episode }
  let(:cassette) { MrVideo::Cassette.find('dummy_cassette') }
  let(:episode) { cassette.episodes[0] }

  subject { episode }

  describe 'properties' do

    describe '#id' do
      let(:id) { episode.id }
      subject { id }
      it { should == episode.url.hash }
    end

    describe '#url' do
      let(:url) { episode.url }
      subject { url }
      it { should == 'http://www.thebellhouseny.com/calendar/' }
    end

    describe '#request_method' do
      let(:request_method) { episode.request_method }
      subject { request_method }
      it { should == 'get' }
    end

    describe '#website_url' do
      let(:website_url) { episode.website_url }
      subject { website_url }
      it { should == 'http://www.thebellhouseny.com' }
    end

    describe '#content' do
      let(:content) { episode.content }
      subject { content }
      it { should match(/<html/) }
    end

    describe '#content_type' do
      let(:content_type) { episode.content_type }
      subject { content_type }
      it { should == 'text/html; charset=UTF-8' }
    end

    describe '#recorded_at' do
      let(:recorded_at) { episode.recorded_at }
      subject { recorded_at }
      it { should == Time.zone.parse('Wed, 04 Jun 2014 15:44:06').to_datetime }
    end

  end # properties

  describe '#to_param' do
    let(:to_param) { episode.to_param }
    subject { to_param }
    it { should == episode.id.to_s }
  end

  describe '#destroy' do
    let(:original_cassette) { MrVideo::Cassette.find('dummy_cassette') }

    before do
      original_cassette.load
      episode.destroy
      cassette.reload
    end

    after do
      original_cassette.save!
    end

    context 'cassette#episodes' do
      it 'should have destroyed the episode' do
        expect(cassette.episodes).to have(2).items
      end
    end

  end

end # MrVideo::Episode