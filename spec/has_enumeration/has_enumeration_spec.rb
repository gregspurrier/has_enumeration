require File.expand_path('../spec_helper', File.dirname(__FILE__))

describe HasEnumeration, 'with invalid values' do
  before(:each) do
    @model = ExplicitlyMappedModel.new
  end

  it 'raises an exception when assigned an invalid value' do
    lambda do
      @model.color = :beige
    end.should raise_error(ArgumentError, ':beige is not one of {:blue, :green, :red}')
  end

  if ActiveRecord::VERSION::MAJOR >= 3
    context 'with ActiveRecord 3.x' do
      it 'raises an exception when finding with an invalid value' do
        lambda do
          ExplicitlyMappedModel.where(:color => :beige).all
        end.should raise_error(ArgumentError, ':beige is not one of {:blue, :green, :red}')
      end

      it 'raises an exception when finding with an invalid value via meta_where' do
        lambda do
          ExplicitlyMappedModel.where(:color.not_eq => :beige).all
        end.should raise_error(ArgumentError, ':beige is not one of {:blue, :green, :red}')
      end
    end
  else
    context 'With ActiveRecord 2.x' do
      it 'raises an exception when finding with an invalid value' do
        lambda do
          ExplicitlyMappedModel.find(:all, :conditions => {:color => :beige})
        end.should raise_error(ArgumentError, ':beige is not one of {:blue, :green, :red}')
      end
    end
  end
end
