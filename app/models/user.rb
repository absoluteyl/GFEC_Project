class User < ActiveRecord::Base
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save :ensure_authentication_token
  has_many :merchandises, dependent: :destroy
  has_many :locations, dependent: :destroy
  has_many :orders
  has_many :line_items
  validates :username, presence: true,
                        uniqueness: { case_sensitive: false },
                        length: {minimum: 3, maximum: 25 }
  validates :mobile, presence: true, length: { is: 10 }
                
  #Paperclip configurations
  has_attached_file :avatar, styles: {
      medium: '375x300>', 
      small: '180x145>',
      thumb: '64x64#'
  }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  #Override build-in as_json method to NOT return password_digest in API
  def as_json(options = {})
      super(options.merge({ 
          except: [:avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at, :authentication_token],
          methods: [:avatar_url_o, :avatar_url_m, :avatar_url_s]
      }))
  end
  def avatar_url_o
      avatar.url
  end
  def avatar_url_m
      avatar.url(:medium)
  end
  def avatar_url_s
      avatar.url(:small)
  end
  
  def ensure_authentication_token
    if authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  private
  
  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
