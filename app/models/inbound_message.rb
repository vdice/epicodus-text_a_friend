class InboundMessage
  sender = params[:From]
  begin
    response = RestClient::Request.new(
      :method => :post,
      :url => "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
      :user => ENV['TWILIO_ACCOUNT_SID'],
      :password => ENV['TWILIO_AUTH_TOKEN'],
      :payload => { :Body => 'hi there!  I\'m a robot',
                    :To => sender,
                    :From => from }
    ).execute
  rescue  RestClient::BadRequest => error
    message = JSON.parse(error.response)['message']
    errors.add(:base, message)
    false
  end
end
