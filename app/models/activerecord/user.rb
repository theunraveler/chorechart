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

  def last_name
    name.split.last unless name.nil?
  end

  def assignments_for(start = Time.current.to_date, finish = Time.current.to_date)
    assigns = []
    groups.each do |group|
      assigns += group.assignments_for(start, finish, [:user])
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
        when 'facebook'
          self.email = account_details['email']
          self.username = account_details['nickname']
          self.name = account_details['name']
        when 'github'
          self.email = account_details['email']
          self.username = account_details['nickname']
          self.name = account_details['name']
        when 'google_oauth2'
          self.email = account_details['email']
          self.username = account_details['email']
          self.name = account_details['name']
      end
    end
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])  
  end

  def password_required?  
    (authentications.empty? || !password.blank?) && super  
  end 

  def to_s
    first_name || username
  end

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).find_by_login(login).first
  end

  def process_pending_invitations
    invites = Invitation.find_all_by_email(email)
    invites.each do |invite|
      memberships.create({:group_id => invite.group_id})
      invite.destroy
    end
  end

end
