require 'spec_helper'
require 'guid'

describe 'routes' do
  let!(:name) { File.join(random_text, random_text, random_text) }
  let!(:id) { Guid.new.to_s }

  describe 'helpers' do
    it { widget_path(name).should == "/widgets/#{name}" }
    it { remove_widget_path(id).should == "/widgets/#{id}/remove" }
    it { replace_widget_path(id).should == "/widgets/#{id}/replace" }
  end

  it 'should route GET /widgets/:id' do
    {get: "/widgets/#{name}"}.should route_to controller: 'widgets', action: 'show', id: name
  end

  it 'should route GET /widgets/:id/remove' do
    {get: "/widgets/#{id}/remove"}.should route_to controller: 'widgets', action: 'remove', id: id
  end

  it 'should route GET /widgets/:id/replace' do
    {get: "/widgets/#{id}/replace"}.should route_to controller: 'widgets', action: 'replace', id: id
  end
end