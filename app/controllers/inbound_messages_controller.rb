class InboundMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @response = InboundMessage.send_response(params)
  end
end
