require 'rails_helper'

describe MrVideo::EpisodesController do
  routes { MrVideo::Engine.routes }

  render_views

  describe '#show' do
    let(:cassette_id) { 'bell_house' }
    let(:id) { 1234 }
    let(:fix_relative_links) { 'false' }
    let(:cassette) { double(:cassette, id: cassette_id) }
    let(:episode) { double(:episode, id: id) }
    let(:content) { '<html><body></body></html>' }
    let(:website_url) { 'http://www.mrvideo.com' }
    let(:content_type) { 'text/html' }
    let(:params) { { 
      cassette_id: cassette_id,
      id: id,
      fix_relative_links: fix_relative_links
    } }
    let(:show) { get(:show, params: params) }

    subject { show }

    before do
      expect(MrVideo::Cassette).to receive(:find).with(cassette_id) { cassette }
      expect(cassette).to receive(:find_episode_by_id).with(id.to_s) { episode }
      expect(episode).to receive(:content) { content }
      allow(episode).to receive(:website_url) { website_url }
      expect(episode).to receive(:content_type) { 'text/html' }
      show
    end
    
    it { should be_successful }

    context 'fix relative links is true' do
      let(:fix_relative_links) { 'true' }
      let(:content) { raise NotImplementedError }
      let(:body) { show.body }

      subject { body }

      context 'when href contains href="/' do
        let(:content) { '<a href="/videos/video_1234" class="interesting">click here</a>' }
        it 'should have correctly replaced the href' do
          expect(body).to match(/href="http:\/\/www\.mrvideo\.com\/videos\/video_1234"/)
        end
      end

      context 'when img contains src="/' do
        let(:content) { '<img src="/videos/video_1234.png" />' }
        it 'should have correctly replaced the src' do
          expect(body).to match(/src="http:\/\/www\.mrvideo\.com\/videos\/video_1234.png"/)
        end
      end

      context 'when @import is relative' do
        let(:content) { '<style>@import url(fun.css);<style/>' }
        it 'should have correctly replaced the url' do
          expect(body).to match(/@import url\(http:\/\/www\.mrvideo\.com\/fun\.css\)/)
        end
      end

    end # fix relative links

  end # show

  describe '#destroy' do
    let(:cassette_id) { 'bell_house' }
    let(:id) { 0 }
    let(:params) { { 
      cassette_id: cassette_id,
      id: id
    } }
    let(:cassette) { double(:cassette) }
    let(:episode) { double(:episode, id: id) }
    let(:destroy) { delete(:destroy, xhr: true, params: params) }

    subject { destroy }

    before do
      expect(MrVideo::Cassette).to receive(:find).with(cassette_id) { cassette }
      expect(cassette).to receive(:find_episode_by_id).with(id.to_s) { episode }
      allow(episode).to receive(:destroy)
      destroy
    end

    it { should be_successful }

    it 'should destroy the episode' do
      expect(episode).to have_received(:destroy)
    end
  end # #destroy

end # MrVideo::EpisodesController