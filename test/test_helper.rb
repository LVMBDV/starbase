ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods
  include AuthenticationHelpers

  parallelize(workers: :number_of_processors)

  def graphql_path
    "/graphql"
  end
end
