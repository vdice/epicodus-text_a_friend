require 'rails_helper'

describe Message do
  before do
    ENV['TWILIO_TEST'] = 'true'
  end

  after do
    ENV['TWILIO_TEST'] = ''
  end

  it {should validate_presence_of :body}
  it {should validate_presence_of :to}
  it {should validate_presence_of :from}

  it "doesn't send the message if twilio gives an error", :vcr => true do
    message = Message.create(:body => 'hi', :to => '1111111', :from => '+15005550006')
    expect(message.send_message).to be false
  end

  it 'sends to an existing contact', :vcr => true do
    contact = Contact.create(name: 'Anony', number: '+15005550006')
    message = Message.create(:body => 'hi', :to => contact.id, :from => '+15005550006')
    expect(message.send_message).to be true
  end
end
