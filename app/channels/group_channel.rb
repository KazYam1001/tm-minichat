class GroupChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def display(data)
    ActionCable.server.broadcast 'group_channel', data['group']
  end
end
