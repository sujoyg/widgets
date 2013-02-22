require 'spec_helper'

describe ApplicationHelper do
  describe '#widget' do
    let!(:html) { random_text :length => 256 }
    let!(:javascript) { random_text :length => 256 }
    let!(:name) { File.join random_text, random_text }
    let!(:options) { {random_text => random_time, random_text => random_url} }
    let!(:widget_id) { Guid.new.to_s }

    before do
      Guid.stub(:new).and_return(widget_id)
      view.stub(:render)
    end

    shared_examples_for 'it renders template corresponding to the widget' do |format|
      it 'should render the specified widget as a template for its content.' do
        content = format == :html ? html : javascript

        view.should_receive(:render).with(
            hash_including template: "widgets/#{name}",
                           formats: [format]
        ).and_return(content)
        helper.widget(name, options).should contain content
      end

      it 'should pass in the options as local parameters.' do
        view.should_receive(:render).with(hash_including locals: hash_including(options),
                                                         formats: [format]
        )
        helper.widget(name, options)
      end

      it 'should pass in the widget id as local parameters.' do
        view.should_receive(:render).with(hash_including locals: hash_including(widget_id: widget_id),
                                                         formats: [format]
        )
        helper.widget(name, options)
      end

      it 'should use supplied widget_id if explicitly specified.' do
        supplied_widget_id = random_text
        view.should_receive(:render).with(hash_including locals: hash_including(widget_id: supplied_widget_id),
                                                         formats: [format]
        )
        helper.widget(name, options.merge(:widget_id => supplied_widget_id))
      end
    end

    describe 'html' do
      it_should_behave_like 'it renders template corresponding to the widget', :html

      it 'should render a div with a unique id.' do
        helper.widget(name, options).should have_selector 'div', :id => widget_id
      end

      it 'should include the widget name as a data attribute.' do
        helper.widget(name, options).should have_selector 'div', :'data-widget' => name
      end

      describe 'style' do
        context 'when a style is specified' do
          let(:style) { random_text }

          it 'renders a div with the specified style.' do
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
            helper.widget(name, options).should_not have_selector 'div[style]'
          end
        end
      end

      describe 'effects' do
        context 'when effects are specified' do
          let(:effects) { random_text }

          it 'renders a div with the specified effects as its class.' do
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
            helper.widget(name, options).should_not have_selector 'div[class]'
          end
        end
      end
    end

    describe 'javascript' do
      it_should_behave_like 'it renders template corresponding to the widget', :js

      it 'should attach a javascript section at the end if the js template exists.' do
        view.should_receive(:render).with(hash_including template: "widgets/#{name}", formats: [:js]).and_return(javascript)

        doc = Nokogiri::HTML helper.widget(name, options)
        script = doc.at('script')

        script.next_sibling.should be_nil
        script.content.should == javascript
      end

      it 'should not attach a javascript section at the end if js template does not exist.' do
        begin
          view.render(random_text)
        rescue ActionView::MissingTemplate => e
          exception = e
        end
        view.should_receive(:render).with(hash_including template: "widgets/#{name}", formats: [:js]).and_raise(exception)

        helper.widget(name, options).should_not have_selector('script')
      end
    end
  end
end