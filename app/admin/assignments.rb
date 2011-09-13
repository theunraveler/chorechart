ActiveAdmin.register Assignment do
  index do
    column :user_id
    column :chore_id
    column :date
    column :created_at
    default_actions
  end
end
