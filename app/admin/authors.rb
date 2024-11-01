ActiveAdmin.register Author do
  menu priority: 2
  # Specify parameters which should be permitted for assignment
  permit_params :name, :email, :avatar

  # or consider:
  #
  # permit_params do
  #   permitted = [:name, :email]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :name
  filter :email
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :avatar do |a|
      image_tag a.avatar.variant(:thumb) if a.avatar.attached?
    end
    column :name
    column :email
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :avatar do |a|
        image_tag a.avatar.variant(:square) if a.avatar.attached?
      end
      row :name
      row :email
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :avatar, as: :file, input_html: { accept: "image/*" }
      f.input :name
      f.input :email
    end
    f.actions
  end
end
