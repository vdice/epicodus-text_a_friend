require 'rails_helper'

RSpec.describe InboundMessage, type: :model do
  before do
    message = { :Body => 'Anybody there?',
                :To => ENV['TWILIO_NUMBER'],
                :From => ENV['TWILIO_NUMBER'] }
    @inbound_message = InboundMessage.new(:message => message)
  end

  it 'saves to db' do
    @inbound_message.save_message
    saved_message = Message.all.first
    expect(Message.all.length).to eq 1
    expect(saved_message.body).to eq @inbound_message.message[:Body]
  end

  it 'sends an auto response' do
    EXPECTED_RESPONSE_BODY = 'Hi there! This is an automatic reply. Only robots will see your text.'

    response = @inbound_message.send_response
    expect(response[:Body]).to eq EXPECTED_RESPONSE_BODY
  end
end
