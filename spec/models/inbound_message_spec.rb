require 'rails_helper'

RSpec.describe InboundMessage, type: :model do
  it 'sends an auto response' do
    EXPECTED_RESPONSE_BODY = 'Hi there! This is an automatic reply. Only robots will see your text.'

    params = { :Body => 'Anybody there?',
               :To => ENV['TWILIO_NUMBER'],
               :From => ENV['TWILIO_NUMBER'] }
    response = InboundMessage.send_response(params)
    expect(response[:Body]).to eq EXPECTED_RESPONSE_BODY
  end
end
