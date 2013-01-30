require 'spec_helper'
require 'guid'

describe ApplicationHelper do
  describe '#component' do
    let(:contents) { random_text :length => 256 }
    let(:name) { File.join random_text, random_text }
    let(:options) { {random_text => random_time, random_text => random_url} }

    it 'should render the specified component as a template for its content.' do
      view.should_receive(:render).with(hash_including :template => "components/#{name}").and_return(contents)

      helper.component(name, options).should contain contents
    end

    it 'should render a div with a unique id.' do
      #id = Guid.new.to_s
      Guid.stub!(:new).and_return(id = Guid.new.to_s)
      view.stub! :render

      helper.component(name, options).should have_selector 'div', :id => id
    end

    it 'should include the component name as a data attribute.' do
      view.stub! :render
      helper.component(name, options).should have_selector 'div', :'data-component' => name
    end

    describe 'style' do
      context 'when a style is specified' do
        let(:style) { random_text }

        it 'renders a div with the specified style.' do
          view.stub! :render

          helper.component(name, options.merge(:style => style)).should have_selector 'div[style]', :style => style
        end

        it 'passes all options excluding the width as locals to the content template.' do
          view.should_receive(:render).with(hash_including :locals => options)
          helper.component name, options.merge(:style => style)
        end
      end

      context 'when style is not specified' do
        it 'renders a div without any style.' do
          view.stub! :render

          helper.component(name, options).should_not have_selector 'div[style]'
        end

        it 'passes all options as locals to the content template.' do
          view.should_receive(:render).with(hash_including :locals => options)
          helper.component(name, options)
        end
      end
    end

    describe 'effects' do
      context 'when effects are specified' do
        let(:effects) { random_text }

        it 'renders a div with the specified effects as its class.' do
          view.stub! :render

          helper.component(name, options.merge(:effects => effects)).should have_selector 'div[class]', :class => effects
        end

        it 'passes all options excluding the width as locals to the content template.' do
          view.should_receive(:render).with(hash_including :locals => options)
          helper.component name, options.merge(:effects => effects)
        end
      end

      context 'when effects are not specified' do
        it 'renders a div without any class.' do
          view.stub! :render

          helper.component(name, options).should_not have_selector 'div[class]'
        end

        it 'passes all options as locals to the content template.' do
          view.should_receive(:render).with(hash_including :locals => options)
          helper.component(name, options)
        end
      end
    end
  end
end