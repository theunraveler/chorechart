class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  # Associations
  with_options :dependent => :destroy do |a|
    a.has_many :memberships
    a.has_many :assignments
    a.has_many :authentications
  end
  has_many :groups, :through => :memberships, :include => [:users]
  has_many :chores, :through => :assignments
  has_many :groupmates, :through => :groups, :source => :users, :uniq => true

  attr_accessor :login

  # Setup accessible (or protected) attributes
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :name, :time_zone

  # Validations
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

  # Callbacks
  after_create :process_pending_invitations

  # Named scopes
  scope :find_by_login, lambda { |login| where('username = ? OR email = ?', login.downcase, login.downcase) }
  scope :not_in_group, lambda { |group| where('id not in (?)', group.user_ids) }

  def update_with_password(params={})
    params.delete(:current_password)
    self.update_without_password(params)
  end

  def first_name
    name.split.first unless name.nil?
  end

  def assignments_for(start = Time.current.to_date, finish = Time.current.to_date)
    assigns = []
    groups.each do |group|
      assigns += group.assignments_for(start, finish)
    end
    assigns.select { |a| a.user == self }
  end

  def apply_omniauth(omniauth, overwrite = false)
    if overwrite
      account_details = omniauth['info']
      case omniauth['provider']
      when 'twitter'
        self.username = account_details['nickname']
        self.name = account_details['name']
      else
        self.email = account_details['email']
        self.username = account_details['nickname']
        self.name = account_details['name']
      end
    end
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end

  def fill_password
    generated_password = Devise.friendly_token.first(6)
    self.password, self.password_confirmation = generated_password, generated_password
  end

  def password_required?
    (authentications.empty? || !new_record?) && super
  end

  def hashed_email
    Digest::MD5.hexdigest(email.strip)
  end

  def to_s
    first_name || username
  end

  # Memoization
  extend ActiveSupport::Memoizable
  memoize :assignments_for

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).find_by_login(login).first
  end

  private

  def process_pending_invitations
    invites = Invitation.find_all_by_email(email)
    invites.each do |invite|
      memberships.create({:group_id => invite.group_id})
      invite.destroy
    end
  end

end
