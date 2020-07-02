class GroupChannel < ApplicationCable::Channel
  def subscribed
    stream_from "group_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def create(data)
    group = Group.create!(name: data['groupName'])
    ActionCable.server.broadcast 'group_channel', group.attributes
  end
end
