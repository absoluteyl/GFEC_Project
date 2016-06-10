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
    
    #Override build-in as_json method to NOT return password_digest in API
    def as_json(options = {})
        super(options.merge({ except: [:password_digest] }))
    end
end