class InboundMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    inbound_message = InboundMessage.new(:message => params)
    @response = inbound_message.send_response()
  end
end
