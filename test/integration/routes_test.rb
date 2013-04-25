require '../test_helper'

class RoutesTest < ActiveSupport::TestCase

test "should route to researchers" do
  assert_routing '/admins/researchers', { :controller => "ResearchersController" }
end

test "should route to questions" do
  assert_routing '/questions/new', { :controller => "QuestionsController" }
end

test "should route to questions" do
  assert_routing '/admin/questions', { :controller => "Admin::QuestionsController"}
end

test "should route to /researchers" do
  assert_routing '/researchers/new', { :controller => "ResearchersController" }
end

end