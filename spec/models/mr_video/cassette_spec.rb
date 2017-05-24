require 'rails_helper'

describe MrVideo::Cassette do
  let(:model_class) { MrVideo::Cassette }
  let(:model) { model_class.find('bell_house') }

  subject { model }

  describe '#id' do
    let(:id) { model.id }
    subject { id }
    it { should == 'bell_house' }

    context 'when cassette is in subdirectory' do
      let(:model) { model_class.find('test_subdirectory/dummy_cassette_2') }
      it { should == 'test_subdirectory%2Fdummy_cassette_2' }
    end
  end

  describe '#name' do
    let(:name) { model.name }
    subject { name }
    it { should == 'bell_house' }
  end

  describe '#updated_at' do
    let(:updated_at) { model.updated_at }
    subject { updated_at }
    it { should be_kind_of(DateTime) }
  end # #updated_at

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

  end # #episodes

  describe '#destroy' do
    before do
      File.stub(:delete)
      model.destroy
    end

    it 'should delete the file' do
      File.should have_received(:delete).with(model.send(:cassette_path))
    end

  end # #destroy

  describe '#to_param' do
    let(:to_param) { model.to_param }
    subject { to_param }
    it { should == 'bell_house' }
  end

  describe '.all' do
    let(:all) { model_class.all }
    subject { all }
    its(:size) { should == 6 }
  end # .all

  describe '.find' do
    context 'when name is from a subdirectory' do
      let(:model) { model_class.find('test_subdirectory%2Fdummy_cassette_2') }
      it { -> { model }.should_not raise_error }
    end
  end

end # MrVideo::Cassette
