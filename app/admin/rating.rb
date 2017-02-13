ActiveAdmin.register Rating do
  permit_params :num, :post

  index do
    selectable_column
    column :num
    column :post
    actions
  end

  form do |f|
    f.inputs 'Параметры' do
      f.input :num,
        as: :select,
        collection: (1..5).to_a
      f.input :post
    end
    f.actions
  end
end
