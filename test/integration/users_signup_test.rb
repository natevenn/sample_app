require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
   test "invalid signup info" do
     get signup_path
     assert_no_difference "User.count" do
       post users_path, user: { name: "",
                                email: "user@invalid.com",
                                password: "foo",
                                password_confirmation: "foo" }
     end
     assert_template 'users/new'
   end

   test 'valid signup info' do
     get signup_path
     assert_difference "User.count", 1 do
       post_via_redirect users_path, user: { name: "Dude",
                                             email: "dude@elduderino.com",
                                             password: "password",
                                             password_confirmation: "password" }
     end
     assert_template "users/show"
   end
end
