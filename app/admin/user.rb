ActiveAdmin.register User do
  permit_params :login, :ip

  index do
    selectable_column
    column :login
    column :ip
    actions
  end

  form do |f|
    f.inputs 'Параметры' do
      f.input :login
      f.input :ip
    end
    f.actions
  end
end
