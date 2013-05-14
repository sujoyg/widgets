require 'spec_helper'

describe WidgetsController do
  before { controller.stub(:render) }

  it { should_not have_layout }

  describe '#remove' do
    let!(:widget_id) { random_text }

    it 'should set @id.' do
      get :remove, id: widget_id
      assigns[:id].should == widget_id
    end
  end

  describe '#replace' do
    let!(:widget_name) { random_text }
    let!(:widget_id) { random_text }
    let!(:options) { random_hash.stringify_keys }
    let!(:params) { options.merge id: widget_id, name: widget_name }

    it 'should set @id.' do
      get :replace, params
      assigns[:id].should == widget_id
    end

    it 'should set @name.' do
      get :replace, params
      assigns[:name].should == widget_name
    end

    it 'should set @options.' do
      get :replace, params
      assigns[:options].should == options
    end
  end

  describe '#show' do
    let!(:widget_name) { random_text }
    let!(:options) { random_hash.stringify_keys }
    let!(:params) { options.merge id: widget_name }

    it 'should set @name.' do
      get :show, params
      assigns[:name].should == widget_name
    end

    it 'should set @options.' do
      get :show, params
      assigns[:options].should == options
    end
  end
end