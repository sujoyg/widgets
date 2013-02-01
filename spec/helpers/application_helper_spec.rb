require 'spec_helper'
require 'guid'

describe ApplicationHelper do
  describe '#widget' do
    let(:contents) { random_text :length => 256 }
    let(:name) { File.join random_text, random_text }
    let(:options) { {random_text => random_time, random_text => random_url} }
    let(:widget_id) { Guid.new.to_s }

    before { Guid.stub(:new).and_return(widget_id) }

    it 'should render the specified widget as a template for its content.' do
      view.should_receive(:render).with(hash_including :template => "widgets/#{name}").and_return(contents)

      helper.widget(name, options).should contain contents
    end

    it 'should pass in the options as local parameters.' do
      view.should_receive(:render).with(hash_including :locals => hash_including(options))
      helper.widget(name, options)
    end

    it 'should pass in the widget id as local parameters.' do
      view.should_receive(:render) do |options|
        options[:locals][:widget_id].should == widget_id
      end

      helper.widget(name, options)
    end

    it 'should not override widget_id if explicitly specified.' do
      overridden_widget_id = random_text

      view.should_receive(:render) do |options|
        options[:locals][:widget_id].should == overridden_widget_id
      end

      helper.widget(name, options.merge(:widget_id => overridden_widget_id))
    end

    it 'should render a div with a unique id.' do
      view.stub! :render

      helper.widget(name, options).should have_selector 'div', :id => widget_id
    end

    it 'should include the widget name as a data attribute.' do
      view.stub! :render
      helper.widget(name, options).should have_selector 'div', :'data-widget' => name
    end

    describe 'style' do
      context 'when a style is specified' do
        let(:style) { random_text }

        it 'renders a div with the specified style.' do
          view.stub! :render

          helper.widget(name, options.merge(:style => style)).should have_selector 'div[style]', :style => style
        end

        it 'passes all options excluding the style as locals to the content template.' do
          view.should_receive(:render) do |options|
	    options[:locals].should_not include :style
	  end

          helper.widget name, options.merge(:style => style)
        end
      end

      context 'when style is not specified' do
        it 'renders a div without any style.' do
          view.stub! :render

          helper.widget(name, options).should_not have_selector 'div[style]'
        end
      end
    end

    describe 'effects' do
      context 'when effects are specified' do
        let(:effects) { random_text }

        it 'renders a div with the specified effects as its class.' do
          view.stub! :render

          helper.widget(name, options.merge(:effects => effects)).should have_selector 'div[class]', :class => effects
        end

        it 'passes all options excluding the effects as locals to the content template.' do
          view.should_receive(:render) do |options|
	    options[:locals].should_not include :effects
	  end

          helper.widget name, options.merge(:effects => effects)
        end
      end

      context 'when effects are not specified' do
        it 'renders a div without any class.' do
          view.stub! :render

          helper.widget(name, options).should_not have_selector 'div[class]'
        end
      end
    end
  end
end