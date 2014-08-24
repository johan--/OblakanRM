module OmniAuth
  module Strategies
    class Oblakan < OmniAuth::Strategies::OAuth2
      option :name, :oblakan

      option :client_options, {
        site: 'https://id.oblakan.ru',
        authorize_path: '/oauth/authorize'
      }

      uid do
        raw_info['uid']
      end

      info do
        {
          email: raw_info['email'],
          username: raw_info['username'],
          avatar: raw_info['avatar'],
          is_male: raw_info['is_male']
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v1/me.json').parsed
      end
    end
  end
end