require "test_helper"

class SignInTest < ActionDispatch::IntegrationTest
  SIGN_IN_QUERY = <<~'GRAPHQL'
    mutation SignIn($emailAddress: String!, $password: String!) {
      signIn(input: {
        credentials: { emailAddress: $emailAddress, password: $password }
      }) {
        errors
      }
    }
  GRAPHQL

  def errors
    JSON.parse(response.body)["data"]["signIn"]["errors"]
  end

  test "user can sign in with correct credentials" do
    user = create :user

    post graphql_path, params: {
      query: SIGN_IN_QUERY,
      variables: {
        emailAddress: user.email_address,
        password: user.password
      }
    }

    assert_response :success
    assert_equal errors.count, 0
    assert signed_in?
  end

  test "user cannot sign in with incorrect credentials" do
    user = create :user

    post graphql_path, params: {
      query: SIGN_IN_QUERY,
      variables: {
        emailAddress: user.email_address,
        password: user.password + "fault"
      }
    }

    assert_response :success
    assert_equal errors.count, 1
    assert_equal errors.first, "Invalid credentials"
    assert_not signed_in?
  end

  test "user cannot sign in without confirming their email address" do
    user = create :user
    user.update(email_confirmed: false)

    post graphql_path, params: {
      query: SIGN_IN_QUERY,
      variables: {
        emailAddress: user.email_address,
        password: user.password
      }
    }

    assert_response :success
    assert_equal errors.count, 1
    assert_equal errors.first, "Email not confirmed yet"
    assert_not signed_in?
  end
end
