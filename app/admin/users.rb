ActiveAdmin.register User do
  index do
    column :username
    column :name
    column :email
    column :is_admin
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end
end
