ActiveAdmin.register User do
  menu parent: :settings, priority: 1

  permit_params :email, :password, :password_confirmation, :avatar, :current_password

  controller do
    def update
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)

      if resource.update(permitted_params[:user])
        redirect_to admin_users_path, notice: "更新成功"
      else
        render :edit
      end
    end

    private

    def password_params
      params.require(:user).permit(:current_password, :password, :password_confirmation)
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

  member_action :change_password, method: [ :get, :patch ] do
    if request.patch?
      if params[:user][:password].blank?
        resource.errors.add(:password, "不能為空")
        render :change_password
      elsif resource.update_with_password(password_params)
        bypass_sign_in(resource) if current_user == resource
        redirect_to admin_user_path(resource), notice: "密碼更新成功"
      else
        render :change_password
      end
    end
  end

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

  action_item :change_password, only: [ :show, :edit ]do
    link_to "更新密碼", change_password_admin_user_path(resource), class: "action-item-button"
  end
end
