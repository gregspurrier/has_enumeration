Given /^an unsaved object having a mapped\-integer enumeration of red, green, and blue$/ do
  @object = MappedIntegerModel.new
end

When /^I assign a symbolic value :([a-z_]+) to the enumeration$/ do |value|
  @assigned = value.to_sym
  @object.color = @assigned
end

When /^I save and reload the object$/ do
  @object.save!
  @object = @object.class.find(@object.id)
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
  MappedIntegerModel.delete_all
  2.times do
    [:red, :green, :blue].each do |color|
      MappedIntegerModel.create!(:color => color)
    end
  end
  @all_objects = MappedIntegerModel.all(:order => :id)
end

When /^I query for objects with the value :([a-z_]+)$/ do |value|
  @desired_color = value.to_sym
  @results = MappedIntegerModel.where(:color => @desired_color).order(:id)
end

Then /^I should get all of the objects having that value$/ do
  @results.should == @all_objects.select {|x| x.color == @desired_color}
end

Then /^I should not get any objects having other values$/ do
  @results.reject {|x| x.color != @desired_color}.should be_empty
end
