Given /^a model with an explicitly-mapped enumeration of red, green, and blue$/ do
  @model_class = ExplicitlyMappedModel
end

Given /^a model with an implicitly-mapped enumeration of red, green, and blue$/ do
  @model_class = ImplicitlyMappedModel
end

Given /^an unsaved instance of that model$/ do
  @object = @model_class.new
end

When /^I assign a symbolic value :([a-z_]+) to the enumeration$/ do |value|
  @assigned = value.to_sym
  @object.color = @assigned
end

When /^I save and reload the object$/ do
  @object.save!
  @object = @model_class.find(@object.id)
end

Then /^it should have the assigned value as its value$/ do
  @object.color.value.should == @assigned
end

Then /^the ([a-z_]+\?) predicate should be (true|false)$/ do |predicate, value|
  if value == 'true'
    expected_value = true
  else
    expected_value = false
  end
  @object.color.send(predicate).should == expected_value  
end


Given /^a set of objects with a variety of values for the enumeration$/ do
  @model_class.delete_all
  2.times do
    [:red, :green, :blue].each do |color|
      @model_class.create!(:color => color)
    end
  end
  @all_objects = @model_class.all(:order => :id)
end

When /^I query for objects with the value :([a-z_]+)$/ do |value|
  @desired_color = value.to_sym
  @results = @model_class.all(:conditions => {:color => @desired_color}, :order => :id)
end

When /^I query for objects with the value :([a-z_]+) via arel$/ do |value|
  @desired_color = value.to_sym
  arel_attr = @model_class.arel_table.attributes[:color]
  @results = @model_class.where(arel_attr.eq(@desired_color)).order(:id)
end

When /^I query for objects with the value :([a-z_]+) via MetaWhere$/ do |value|
  @desired_color = value.to_sym
  @results = @model_class.where(:color.eq => @desired_color).order(:id)
end

Then /^I should get all of the objects having that value$/ do
  @results.should == @all_objects.select {|x| x.color.value == @desired_color}
end

Then /^I should not get any objects having other values$/ do
  @results.reject {|x| x.color.value == @desired_color}.should be_empty
end
