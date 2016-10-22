collection :@short_urls
attributes :id, :user_id, :original_url

node(:shorty){|r| r.shorty_full}
