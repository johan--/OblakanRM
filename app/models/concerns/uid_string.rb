module UIDString
  extend ActiveSupport::Concern

  included do
    before_create :generate_uid
  end

  protected

  def generate_uid
    self.uid = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless self.class.where(uid: random_token).exists?
    end
  end
end