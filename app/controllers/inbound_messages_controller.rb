class InboundMessagesController < ApplicationController
  def create
    InboundMessage.new(params)
  end
end
