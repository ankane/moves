require "spec_helper"
require "moves"
require "date"

shared_examples "an api endpoint" do |name|
  context "#{name}" do
    before(:each) do
      stub_get("#{path}#{param_pattern}").
        to_return(:body => fixture('daily_summary.json'))
    end

    context 'single day' do
      let(:param_pattern) { '/?(\d{8}|\d{4}-\d{2}-\d{2})' }

      it { expect(client.send(method)).to be_a_valid_response }
      it { expect(client.send(method, day)).to be_a_valid_response }
      it { expect(client.send(method, time)).to be_a_valid_response }
      it { expect(client.send(method, date_time)).to be_a_valid_response }
      it { expect(client.send(method, date)).to be_a_valid_response }
    end

    context 'specific week' do
      let(:param_pattern) { '/?(\d{4}-W\d{2})' }

      it { expect(client.send(method, week)).to be_a_valid_response }
    end

    context 'specific month' do
      let(:param_pattern) { '/?(\d{6}|\d{4}-\d{2})' }

      it { expect(client.send(method, month)).to be_a_valid_response }
    end

    context 'date range' do
      let(:param_pattern) { '/?from=\d{8}|\d{4}-\d{2}-\d{2}&to=\d{8}|\d{4}-\d{2}-\d{2}' }

      it { expect(client.send(method, from_to)).to be_a_valid_response }
      it { expect(client.send(method, from_to_time)).to be_a_valid_response }
      it { expect(client.send(method, time_range)).to be_a_valid_response }
    end
  end
end

describe Moves::Client do
  subject(:client) { Moves::Client.new('XXX') }

  let(:today) { Time.now.strftime("%Y-%m-%d") }
  let(:day) { "2013-06-20" }
  let(:week) { "2013-W25" }
  let(:month) { "2013-06" }
  let(:from_to) { {:from => "2013-06-20", :to => "2013-06-23"} }
  let(:time) { Time.now }
  let(:date_time) { DateTime.now }
  let(:date) { Date.today }
  let(:from_to_time) { {:from => time - 86400, :to => time} }
  let(:time_range) { (time - 86400)..time }

  describe '#profile' do
    before do
      stub_get('user/profile').to_return(:body => fixture('profile.json'))
    end

    it { expect(client.profile).to be_an_instance_of(Hash) }
  end

  it_behaves_like "an api endpoint", 'daily summary' do
    let(:path) { "user/summary/daily" }
    let(:method) { :daily_summary }
  end

  it_behaves_like "an api endpoint", 'daily activity' do
    let(:path) { "user/activities/daily" }
    let(:method) { :daily_activities }
  end

  it_behaves_like "an api endpoint", 'daily place' do
    let(:path) { "user/places/daily" }
    let(:method) { :daily_places }
  end

  it_behaves_like "an api endpoint", 'daily storyline' do
    let(:path) { "user/storyline/daily" }
    let(:method) { :daily_storyline }
  end

end
