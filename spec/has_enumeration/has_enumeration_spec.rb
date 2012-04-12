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

      #TODO: handle porting to some other meta_where equivalent that is forward compatible with ActiveRecord 3.1.x+
      #it 'raises an exception when finding with an invalid value via meta_where' do
      #  lambda do
      #    ExplicitlyMappedModel.where(:color.not_eq => :beige).all
      #  end.should raise_error(ArgumentError, ':beige is not one of {:blue, :green, :red}')
      #end
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

describe HasEnumeration, 'with an uninitialied value' do
  context 'in a newly-created object' do
    it 'returns nil for the value of the enumeration' do
      ExplicitlyMappedModel.new.color.should be_nil
    end
  end

  context 'in an existing object' do
    it 'returns nil for the value of the enumeration' do
      object = ExplicitlyMappedModel.find(ExplicitlyMappedModel.create!.id)
      object.color.should be_nil
    end
  end
end

describe HasEnumeration, 'assignment of nil' do
  it 'sets the enumeration to nil' do
    object = ExplicitlyMappedModel.new(:color => :red)
    object.color = nil
    object.color.should be_nil
  end

  it 'persists across a trip to the database' do
    object = ExplicitlyMappedModel.create!(:color => :red)
    object.color = nil
    object.save!
    ExplicitlyMappedModel.find(object.id).color.should be_nil
  end
end

describe HasEnumeration, 'string formatting' do
  it 'returns the value as a string if to_s is called on it'  do
    object = ExplicitlyMappedModel.new(:color => :red)
    object.color.to_s.should == 'red'
  end
end
