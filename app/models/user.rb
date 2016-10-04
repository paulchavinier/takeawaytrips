class User < ActiveRecord::Base
  mount_uploader :photo, PhotoUploader
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  has_many :guides, dependent: :destroy
  has_many :cards, through: :guides
  has_many :bloguers, dependent: :destroy

  after_create :send_welcome_email

  def self.find_for_facebook_oauth(auth)
    user_params = {
      provider: auth.provider,
      uid: auth.uid,
      email: auth.info.email,
      password: Devise.friendly_token[0,20], # Fake password for validation
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      picture: auth.info.image,
      token: auth.credentials.token,
      token_expiry: Time.at(auth.credentials.expires_at),
    }
    #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    #     user.provider = auth.provider
    #     user.uid = auth.uid
    #     user.email = auth.info.email
    #     user.password = Devise.friendly_token[0,20]  # Fake password for validation
    #     user.first_name = auth.info.first_name
    #     user.last_name = auth.info.last_name
    #     user.picture = auth.info.image
    #     user.token = auth.credentials.token
    #     user.token_expiry = Time.at(auth.credentials.expires_at)
    #   end
    if self.where(provider: auth.provider, uid: auth.uid).first
      user = self.where(provider: auth.provider, uid: auth.uid).first
      user.update(user_params)
    else
      user = self.create(user_params)
    end

    user
  end


  def avatar
    if picture
      picture
    else
      photo
    end
  end

  def get_friendslist

   graph = Koala::Facebook::API.new(self.token)
   graph.get_connections("me", "friends")
  end

  def friendslist
    @friends = self.get_friendslist
    @users = []
    while @friends != nil
      @friends.each do |friend|
        @users << User.find_by(uid: friend["id"])
      end
      @friends = @friends.next_page
    end
    @users
  end

  def initials
    "#{self.first_name.first}#{self.last_name.first}"
  end

  private

  def send_welcome_email #l'envoi du mail se fait via le Model. On peut aussi creer des methodes d envoi d email dans le controller
      UserMailer.welcome(self).deliver_now # self : je passe a la methode le model U ser
  end


end
