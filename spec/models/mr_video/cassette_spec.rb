require 'rails_helper'

describe MrVideo::Cassette do
  let(:model_class) { MrVideo::Cassette }
  let(:name) { 'bell_house' }
  let(:id) { MrVideo::IdService.encode(name) }
  let(:model) { model_class.find(id) }

  subject { model }

  describe '#id' do
    subject { model.id }
    it { should == id }

    context 'when cassette is in subdirectory' do
      let(:name) { 'test_subdirectory/dummy_cassette_2' }
      it { should == id }
    end
  end

  describe '#name' do
    subject { model.name }
    it { should == 'bell_house' }
  end

  describe '#updated_at' do
    let(:updated_at) { model.updated_at }
    subject { updated_at }
    it { should be_kind_of(DateTime) }
  end

  describe '#episodes' do
    let(:episodes) { model.episodes }
    subject { episodes }
    it { should have(3).items }

    describe '1st episode' do
      let(:episode) { episodes[0] }
      subject { episode }
      its(:cassette) { should == model }
    end

    describe '#find' do
      let(:episode) { episodes.find(0) }
      subject { episode }
      it { should be }
    end

  end

  describe '#destroy' do
    before do
      File.stub(:delete)
      model.destroy
    end

    it 'should delete the file' do
      File.should have_received(:delete).with(model.send(:cassette_path))
    end
  end

  describe '#to_param' do
    let(:to_param) { model.to_param }
    subject { to_param }
    it { should == model.id }
  end

  describe '.all' do
    let(:all) { model_class.all }
    subject { all }
    its(:size) { should == 6 }
  end # .all

  describe '.find' do
    context 'when name is from a subdirectory' do
      let(:name) { 'test_subdirectory/dummy_cassette_2' }
      let(:model) { model_class.find(id) }
      it { -> { model }.should_not raise_error }
    end
  end

end
