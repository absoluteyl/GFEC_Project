class Merchandise < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :location
  has_many :line_items
  has_many :orders
  
  before_destroy :ensure_not_referenced_by_any_line_item
  
  validates :user_id, presence: true
  validate :user_id_not_changed
  validates :title, presence: true, length: { minimum: 3, maximum: 50}
  validates :description, presence: true, length: { minimum: 10, maximum: 300}
  validates :price, presence: true, numericality: { only_integer: true }
  validates :amount, presence: true, numericality: { only_integer: true }
  validates :category_id, presence: true
  # Paperclip configurations
  has_attached_file :image_1, styles: {
    medium: '375x300>', 
    small: '180x145>',
    thumb: '64x64#'
  }
  has_attached_file :image_2, styles: {
    medium: '375x300>', 
    small: '180x145>',
    thumb: '64x64#'
  }
  has_attached_file :image_3, styles: {
    medium: '375x300>', 
    small: '180x145>',
    thumb: '64x64#'
  }
  validates_attachment_content_type :image_1, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :image_2, content_type: /\Aimage\/.*\Z/
  validates_attachment_content_type :image_3, content_type: /\Aimage\/.*\Z/
  
  #temporary set image_1 as mandotory for iOS app testing
  validates :image_1, attachment_presence: true
  
  def as_json(options = {})
    super(options.merge({ 
    except: [
      :image_1_file_name, :image_1_content_type, :image_1_file_size, :image_1_updated_at,
      :image_2_file_name, :image_2_content_type, :image_2_file_size, :image_2_updated_at,
      :image_3_file_name, :image_3_content_type, :image_3_file_size, :image_3_updated_at,
    ],
    methods: [
      :image1_url_o, :image1_url_m, :image1_url_s, :image1_url_t,
      :image2_url_o, :image2_url_m, :image2_url_s,
      :image3_url_o, :image3_url_m, :image3_url_s,
    ]
  }))
  end
  def image1_url_o
    if image_1?
      image_1.url
    end
  end
  def image1_url_m
    if image_1?
      image_1.url(:medium)
    end
  end
  def image1_url_s
    if image_1?
      image_1.url(:small)
    end
  end
  def image1_url_t
    if image_1?
      image_1.url(:thumb)
    end
  end
  def image2_url_o
    if image_2?
      image_2.url
    end
  end
  def image2_url_m
    if image_2?
      image_2.url(:medium)
    end
  end
  def image2_url_s
    if image_2?
      image_2.url(:small)
    end
  end
  def image3_url_o
    if image_3?
      image_3.url
    end
  end
  def image3_url_m
    if image_3?
      image_3.url(:medium)
    end
  end
  def image3_url_s
    if image_3?
      image_3.url(:small)
    end
  end
  
  
  private
  #Forbid user_id to be changed
  def user_id_not_changed
    if user_id_changed? && self.persisted?
      errors.add(:user_id, "Change of user_id not allowed!")
    end
  end
  
  def ensure_not_referenced_by_any_line_item 
    if line_items.empty?
      return true 
    else
      errors.add(:base, 'Line Items present')
      return false 
    end
  end
end