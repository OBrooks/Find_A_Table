json.array! @notifications do |notification|
  json.id notification.id
  # json.recipient notification.recipient
  json.actor notification.actor.nickname
  json.action notification.action
  json.notifiable do
    json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
  end
  json.url chatroom_path(notification.notifiable, anchor: dom_id(notification.notifiable))
end
