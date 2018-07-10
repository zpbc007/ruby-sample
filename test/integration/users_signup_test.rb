require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
    test "invalid signup information" do
        get signup_path
        assert_no_difference 'User.count' do
            post users_path, params: {
                user: {
                    name: "",
                    email: 'user@invalid',
                    password: 'foo',
                    password_confirmation: 'bar'
                }
            }
        end
        assert_template 'users/new'
        assert_select 'div#error_explanation'
        assert_select 'div.alert.alert-danger'
    end

    test "valid signup information" do
        get signup_path
        assert_difference "User.count", 1 do
            post signup_path, params: {
                user: {
                    name: '测试用户1',
                    email: "user@qq.com",
                    password: '123456',
                    password_confirmation: '123456'
                }
            }
        end
        follow_redirect!
        assert_template 'users/show'
        assert_not flash.content
    end
end
