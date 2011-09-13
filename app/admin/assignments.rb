ActiveAdmin.register Assignment do
  controller.authorize_resource
  
  index do
    column :user_id
    column :chore_id
    column :date
    column :created_at
    default_actions
  end
end
