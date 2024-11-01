ActiveAdmin.register User do
  menu parent: :settings, priority: 1

  permit_params :email, :password, :password_confirmation, :avatar

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      if resource.update(permitted_params[:user])
        redirect_to admin_users_path, notice: "更新成功"
      else
        render :edit
      end
    end
  end

  index do
    selectable_column
    id_column
    column :avatar do |u|
      image_tag u.avatar.variant(:thumb) if u.avatar.attached?
    end
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    attributes_table_for(resource) do
      row :id
      row :avatar do |u|
        image_tag u.avatar.variant(:square) if u.avatar.attached?
      end
      row :email
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs do
      if f.object.persisted? && f.object.avatar.attached?
        div do
          image_tag f.object.avatar.variant(:square)
        end
      end
      f.input :avatar, as: :file, input_html: { accept: "image/*" }
      f.input :email
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
    end
    f.actions
  end

end
