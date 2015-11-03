require 'rails_helper'

describe "inbound text message" do

  before do
    ENV['TWILIO_TEST'] = 'true'
  end

  after do
    ENV['TWILIO_TEST'] = ''
  end

  it "sends an auto response" do
    expected_response_body = 'Hi there! This is an automatic reply. Only robots will see your text.'
    params = { :Body => 'Anybody there?',
               :To => ENV['TWILIO_NUMBER'],
               :From => ENV['TWILIO_NUMBER'] }

    response = RestClient.post "http://localhost:3000/inbound_messages", params

    expect(response.include?(expected_response_body)).to be true
  end
end
