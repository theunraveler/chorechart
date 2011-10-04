class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  with_options :dependent => :destroy do |a|
    a.has_many :memberships
    a.has_many :assignments
    a.has_many :authentications
  end
  has_many :groups, :through => :memberships, :include => [:users]
  has_many :chores, :through => :assignments

  attr_accessor :login

  # Setup accessible (or protected) attributes for your model
  attr_accessible :login, :username, :email, :password, :password_confirmation, :remember_me, :name

  # Validations
  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

  scope :find_by_login, lambda { |login| where({:username => login.downcase} | {:email => login.downcase}) }

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

  def assignments_for(start = Date.today, finish = Date.today)
    assigns = []
    groups.each do |group|
      assigns += group.assignments_for(start, finish, [:user])
    end
    assigns.select { |a| a.user == self }
  end

  def self.new_from_omniauth(auth)
    case auth['provider']
      when 'twitter'
        account_details = auth['user_info']
        self.new({:username => account_details['nickname'], :name => account_details['name']})
      when 'facebook'
        account_details = auth['user_info']
        self.new({:email => account_details['email'], :username => account_details['nickname'], :name => account_details['name']})
      when 'github'
        account_details = auth['user_info']
        self.new({:email => account_details['email'], :username => account_details['nickname'], :name => account_details['name']})
      else
        self.new
    end
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

end
