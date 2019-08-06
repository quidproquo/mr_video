require 'rails_helper'

describe MrVideo::Episode do
  let(:episode_class) { MrVideo::Episode }
  let(:name) { 'dummy_cassette' }
  let(:id) { MrVideo::IdService.encode(name) }
  let(:cassette) { MrVideo::Cassette.find(id) }
  let(:episode) { cassette.episodes[0] }

  subject { episode }

  describe 'properties' do

    describe '#id' do
      subject { episode.id }
      it { should == MrVideo::IdService.encode(episode.url) }
    end

    describe '#url' do
      subject { episode.url }
      it { should == 'http://www.thebellhouseny.com/calendar/' }
    end

    describe '#request_method' do
      subject { episode.request_method }
      it { should == 'get' }
    end

    describe '#website_url' do
      subject { episode.website_url }
      it { should == 'http://www.thebellhouseny.com' }
    end

    describe '#content' do
      subject { episode.content }
      it { should match(/<html/) }
    end

    describe '#content_type' do
      subject { episode.content_type }
      it { should == 'text/html; charset=UTF-8' }
    end

    describe '#recorded_at' do
      subject { episode.recorded_at }
      it { should == Time.zone.parse('Wed, 04 Jun 2014 15:44:06').to_datetime }
    end

  end

  describe '#to_param' do
    subject { episode.to_param  }
    it { should == episode.id.to_s }
  end

  describe '#destroy' do
    let(:name) { 'dummy_cassette' }
    let(:id) { MrVideo::IdService.encode(name) }
    let(:original_cassette) { MrVideo::Cassette.find(id) }

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

end