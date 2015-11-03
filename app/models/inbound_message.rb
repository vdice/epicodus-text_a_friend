class InboundMessage
  attr_reader(:message)

  define_method :initialize do |attributes|
    @message = attributes.fetch :message
  end

  def save_message
    Message.create(:body => @message[:Body], :to => @message[:To], :from => @message[:From])
  end

  def send_response
    payload = { :Body => 'Hi there! This is an automatic reply. Only robots will see your text.',
                :To => @message[:From],
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
