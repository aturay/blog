ActiveAdmin.register Ip do
  permit_params :ip

  index do
    selectable_column
    column :ip
    actions
  end

  form do |f|
    f.inputs 'Параметры' do
      f.input :ip
    end
    f.actions
  end
end
