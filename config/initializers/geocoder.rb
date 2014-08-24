Geocoder.configure(
    :lookup => :yandex,
    :api_key => 'ABYu41IBAAAASjD8GAMAWIqG12MZT4nIp8tLFL-ZfF8L7jUAAAAAAAAAAAAtud_1xgQtlkBtQs1oi2j0I0qnUg==',
    :timeout => 5,
    :language => 'ru',
    :cache => Redis.new(host: ENV['REDIS_HOST'])
)