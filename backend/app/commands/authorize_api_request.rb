class AuthorizeApiRequest
  prepend SimpleCommand
  def initialize(headers = {})
    @headers = headers
  end

  # Method to run in SimpleCommand.
  #
  # @param [Object] - headers from a request
  def call
    user
  end

  private

  attr_reader :headers

  # TODO: Will be changed in future to check JWT decoded token
  # Finds the associated user from the decoded auth token or adds
  # error if user is not found.
  def user
    @user ||= User.find_by(session_id: decoded_auth_token) if decoded_auth_token
    @user || errors.add(:token, 'Invalid token') && nil
  end

  # TODO: Will use the JWT gem .decode method to decode token header
  # Gets the decoded auth token from the Authorization header
  def decoded_auth_token
    @decoded_auth_token ||= http_auth_header
  end

  # Grabs the authorization header from the list of headers in the request.
  #
  # @return [String | nil] - Bearer token from the Authorization Header,
  #   or nil if the header isn't present.
  def http_auth_header
    return headers['Authorization'].split.last if headers['Authorization'].present?

    errors.add(:token, 'Missing Token')
    nil
  end
end
