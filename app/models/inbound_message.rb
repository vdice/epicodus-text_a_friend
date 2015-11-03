class InboundMessage

  def self.send_response params
    payload = { :Body => 'Hi there! This is an automatic reply. Only robots will see your text.',
                :To => params[:From],
                :From => ENV['TWILIO_NUMBER']  }

    RestClient::Request.new(
      :method => :post,
      :url => "https://api.twilio.com/2010-04-01/Accounts/#{ENV['TWILIO_ACCOUNT_SID']}/Messages.json",
      :user => ENV['TWILIO_ACCOUNT_SID'],
      :password => ENV['TWILIO_AUTH_TOKEN'],
      :payload => payload
    ).execute

    payload
  end
end
