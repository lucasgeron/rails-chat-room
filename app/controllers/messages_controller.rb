class MessagesController < ApplicationController

  before_action :set_room, only: %i[ new create destroy]
  before_action :set_message, only: %i[ destroy ]

  def new
    @message = @room.messages.new
  end

  def create
    @message = @room.messages.create!(message_params)
    respond_to do |format|
      format.html { redirect_to @room }
      format.turbo_stream
    end
  end

  def destroy
    @target = "message_#{@message.id}"
    @message.destroy
    respond_to do |format|
      format.html { redirect_to @room, notice: "Message was successfully destroyed." }
      format.turbo_stream
    end
  end

  private

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
  
end