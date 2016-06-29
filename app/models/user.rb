class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
         
  has_many :merchandises, dependent: :destroy
  has_many :locations, dependent: :destroy
  validates :username, presence: true,
                        uniqueness: { case_sensitive: false },
                        length: {minimum: 3, maximum: 25 }
  validates :mobile, length: { is: 10 }
                
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
            except: [:avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at],
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
end
