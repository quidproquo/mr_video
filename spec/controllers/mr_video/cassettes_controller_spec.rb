require 'rails_helper'

describe MrVideo::CassettesController do
  routes { MrVideo::Engine.routes }

  render_views

  describe '#index' do
    let(:index) { get(:index) }

    subject { index }

    before do
      index
    end

    it { should be_success }
  end

  describe '#show' do
    let(:id) { 'bell_house' }
    let(:params) { { id: id } }
    let(:show) { get(:show, params) }

    subject { show }

    before do
      show
    end

    it { should be_success }
  end

  describe '#destroy' do
    let(:id) { 'bell_house' }
    let(:cassette) { double(:cassette, id: id) }
    let(:params) { { id: id } }
    let(:destroy) { xhr(:delete, :destroy, params) }

    subject { destroy }

    before do
      expect(MrVideo::Cassette).to receive(:find).with(id) { cassette }
      allow(cassette).to receive(:destroy)
      destroy
    end

    it { should be_success }

    it 'should destroy the cassette' do
      expect(cassette).to have_received(:destroy)
    end
  end # #destroy

end # MrVideo::CassettesController