class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Associations
  has_many :memberships
  has_many :groups, :through => :memberships
  has_many :assignments
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

  def get_chores_for_date(date)
    assignments.select { |a| a.date == date }
  end

  protected

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    where(conditions).find_by_login(login).first
  end

end
