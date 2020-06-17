require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
  end

  def setup
	@user = users(:michael)
	@other_user = users(:archer)
  end

	test "should redirect edit when logged in as wrong user" do
		log_in_as(@other_user)
		get edit_user_path(@user)
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect update when logged in as wrong user" do
		log_in_as(@other_user)
		patch user_path(@user), params: { user: { newame: @user.name,
													email: @user.email } }
		assert flash.empty?
		assert_redirected_to root_url
	end

	test "should redirect index when not logged in" do
		get users_path
		assert_redirected_to login_url
	end

	test "should not allow the admin attribute to be edited via the web" do
		log_in_as(@other_user)
		assert_not @other_user.admin?
		patch user_path(@other_user), params: {user: { 	password: "password",
														password_confirmation: "password",
														admin: 1 } }
		assert_not @other_user.admin?
		end
end
