ActiveAdmin.register Post do
  permit_params :title, :content, :user, :ip

  index do
    selectable_column
    column :title
    column :content
    column :user
    column :ip
    actions
  end

  form do |f|
    f.inputs 'Параметры' do
      f.input :title
      f.input :content
      f.input :user
      f.input :ip
    end
    f.actions
  end
end
