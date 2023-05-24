# Preview all emails at http://localhost:3000/rails/mailers/test_mailer
class TestMailerPreview < ActionMailer::Preview
  default from: 'hello@wyshlist.net'

  def hello
    mail(
      subject: 'Hello from Postmark',
      to: 'hello@wyshlist.net',
      from: 'hello@wyshlist.net',
      html_body: '<strong>Hello</strong> dear Postmark user.',
      track_opens: 'true',
      message_stream: 'outbound')
  end
end
