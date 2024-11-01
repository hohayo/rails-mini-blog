ActiveAdmin.register Post do
  # Specify parameters which should be permitted for assignment
  permit_params :title, :body, :published_at, :author_id

  # or consider:
  #
  # permit_params do
  #   permitted = [:title, :body, :published_at, :author_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # For security, limit the actions that should be available
  actions :all, except: []

  # Add or remove filters to toggle their visibility
  filter :id
  filter :title
  filter :body
  filter :published_at
  filter :author
  filter :created_at
  filter :updated_at

  # Add or remove columns to toggle their visibility in the index action
  index do
    selectable_column
    id_column
    column :title
    column :body
    column :published_at
    column :author
    column :created_at
    column :updated_at
    actions
  end

  # Add or remove rows to toggle their visibility in the show action
  show do
    attributes_table_for(resource) do
      row :id
      row :title
      row :body
      row :published_at
      row :author
      row :created_at
      row :updated_at
    end
  end

  # Add or remove fields to toggle their visibility in the form
  form do |f|
    f.semantic_errors(*f.object.errors.attribute_names)
    f.inputs do
      f.input :title
      f.input :body
      f.input :published_at
      f.input :author
    end
    f.actions
  end
end
