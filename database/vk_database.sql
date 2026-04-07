-- Replication:
-- - primary-replica (1 sync + async)
-- - replication factor 3

-- Sharding:
-- - users domain → key by user_id
-- - chats domain → key by chat_id


Table users {
  id integer [primary key]
  username varchar
  description varchar
  city varchar
  avatar_media_id integer
}

Table interests {
  id integer [primary key]
  name varchar
}

Table user_interests {
  user_id integer
  interest_id integer
}

Table posts {
  id integer [primary key]
  description varchar
  user_id integer [not null]
  created_at timestamp
}

Table post_media {
  post_id integer
  media_id integer
}

Table media {
  id integer [primary key]
  url varchar
  type varchar // photo, video, audio
}

Table likes {
  user_id integer
  post_id integer
}

Table comments {
  id integer [primary key]
  post_id integer
  user_id integer
  content varchar
  created_at timestamp
}

Table chats {
  id integer [primary key]
}

Table chat_users {
  chat_id integer
  user_id integer
}

Table messages {
  id integer [primary key]
  chat_id integer
  sender_id integer
  content varchar
  is_read boolean
  created_at timestamp
}

Table relations {
  user_id integer
  target_user_id integer
  type varchar // friend, follower, relationship
}

Ref: posts.user_id > users.id

Ref: user_interests.user_id > users.id
Ref: user_interests.interest_id > interests.id

Ref: post_media.post_id > posts.id
Ref: post_media.media_id > media.id

Ref: users.avatar_media_id > media.id

Ref: likes.user_id > users.id
Ref: likes.post_id > posts.id

Ref: comments.user_id > users.id
Ref: comments.post_id > posts.id

Ref: chat_users.chat_id > chats.id
Ref: chat_users.user_id > users.id

Ref: messages.chat_id > chats.id
Ref: messages.sender_id > users.id

Ref: relations.user_id > users.id
Ref: relations.target_user_id > users.id