class View < ApplicationRecord
    validates :user_id, presence: true, if: :unique
    
    def unique
      !View.exists?( user_id: :user_id, article_id: :article_id)
    end
end
