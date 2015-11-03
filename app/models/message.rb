class Message < ActiveRecord::Base
  has_and_belongs_to_many :contacts

  validates :body, presence: true
  validates :to, presence: true
  validates :from, presence: true

  def send_message

    twilio_account_sid = ENV['TWILIO_TEST'] ? ENV['TWILIO_TEST_ACCOUNT_SID'] : ENV['TWILIO_ACCOUNT_SID']
    twilio_auth_token = ENV['TWILIO_TEST'] ? ENV['TWILIO_TEST_AUTH_TOKEN'] : ENV['TWILIO_AUTH_TOKEN']

    # For mass texting:
    if !self.contacts.any?
      if self.to && self.to.length > 5 # probably a number
        self.contacts = [Contact.create(:name => 'Anonymous', :number => to)]
      else
        self.contacts = [Contact.find(to)]
      end
    end

    success = true
    self.contacts.each do |contact|
      begin
        response = RestClient::Request.new(
          :method => :post,
          :url => "https://api.twilio.com/2010-04-01/Accounts/#{twilio_account_sid}/Messages.json",
          :user => twilio_account_sid,
          :password => twilio_auth_token,
          :payload => { :Body => body,
                        :To => contact.number,
                        :From => from ? from : ENV['TWILIO_NUMBER'] }
        ).execute
      rescue RestClient::BadRequest => error
        message = JSON.parse(error.response)['message']
        errors.add(:base, message)
        success = false
      end
    end
    success
  end
end
