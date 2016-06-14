class User <ActiveRecord::Base
    has_many :merchandises, dependent: :destroy
    before_save { self.email = email.downcase }
    validates :username, presence: true,
                        uniqueness: { case_sensitive: false },
                        length: {minimum: 3, maximum: 25 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true,
                uniqueness: { case_sensitive: false },
                length: { maximum: 105 },
                format: {with: VALID_EMAIL_REGEX }
    validates :mobile, presence: true,
                length: { is: 10 }
    has_secure_password
    
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
            except: [:password_digest, :avatar_file_name, :avatar_content_type, :avatar_file_size, :avatar_updated_at],
            methods: [:avatar_url_o, :avatar_url_m, :avatar_url_s]
        }))
    end
    def avatar_url_o
        if avatar?
            avatar.url
        end
    end
    def avatar_url_m
        if avatar?
            avatar.url(:medium)
        end
    end
    def avatar_url_s
        if avatar?
            avatar.url(:small)
        end
    end
end