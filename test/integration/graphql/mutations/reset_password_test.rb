require "test_helper"

class ResetPasswordTest < ActionDispatch::IntegrationTest
  RESET_PASSWORD_QUERY = <<~'GRAPHQL'
    mutation ResetPassword($token: String!, $password: String!) {
      resetPassword(input: { token: $token, password: $password }) {
        errors
      }
    }
  GRAPHQL

  def errors
    JSON.parse(response.body)["data"]["resetPassword"]["errors"]
  end

  test "user can reset their password" do
    user = create(:user)

    post graphql_path, params: {
      query: RESET_PASSWORD_QUERY,
      variables: {
        token: user.password_reset,
        password: Faker::Internet.password
      }
    }

    assert_response :success
    assert_equal errors.count, 0
  end

  test "user cannot reset their password with invalid token" do
    user = create(:user)

    post graphql_path, params: {
      query: RESET_PASSWORD_QUERY,
      variables: {
        token: user.password_reset + "fault",
        password: Faker::Internet.password
      }
    }

    assert_response :success
    assert_equal errors.count, 1
  end
end
