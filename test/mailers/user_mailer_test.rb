require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  test "signup_email" do
    mail = UserMailer.signup_email
    assert_equal "Signup email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
