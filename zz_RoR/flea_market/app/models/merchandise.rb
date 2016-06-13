class Merchandise < ActiveRecord::Base
    belongs_to :user
    validates :user_id, presence: true
    validate :user_id_not_changed
    validates :title, presence: true, length: { minimum: 3, maximum: 50}
    validates :description, presence: true, length: { minimum: 10, maximum: 300}
    validates :price, presence: true, numericality: { only_integer: true }
    validates :amount, presence: true, numericality: { only_integer: true }
    # Paperclip configurations
    has_attached_file :image_1, styles: {
        medium: '300x300>', 
        small: '140x140>',
        thumb: '64x64!'
    }
    has_attached_file :image_2, styles: {
        medium: '300x300>', 
        small: '140x140>',
        thumb: '64x64!'
    }
    has_attached_file :image_3, styles: {
        medium: '300x300>', 
        small: '140x140>',
        thumb: '64x64!'
    }
    validates_attachment_content_type :image_1, content_type: /\Aimage\/.*\Z/
    validates_attachment_content_type :image_2, content_type: /\Aimage\/.*\Z/
    validates_attachment_content_type :image_3, content_type: /\Aimage\/.*\Z/
    
  private
  #Forbid user_id to be changed
  def user_id_not_changed
    if user_id_changed? && self.persisted?
      errors.add(:user_id, "Change of user_id not allowed!")
    end
  end
end