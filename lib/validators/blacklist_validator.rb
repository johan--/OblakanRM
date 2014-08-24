class BlacklistValidator < ActiveModel::Validator
  def validate (record)
    if Blacklist.exists?(user_id: record.user_id)
      record.errors.add :user_id, 'User in blacklist'
    end
  end
end