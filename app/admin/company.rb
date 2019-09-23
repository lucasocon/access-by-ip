ActiveAdmin.register Company do
  permit_params :name, :responsible_id, :customers_type, :timezone,

  index do
    id_column
    column :name
    column :responsible do |c|
      c.responsible.full_name if c.responsible_id
    end
    column :timezone
    column :created_at
    column :customers_type do |c|
      Company.customers_types[c.customers_type] == 'regular' ? 'client' : Company.customers_types[c.customers_type]
    end
  end

  show do
    attributes_table do
      row :id
      row :name
      row :responsible_id
      row :timezone
      row :created_at
      row :updated_at
      row :has_funds
      row :has_pip_features
    end
  end

  filter :name
  filter :responsible_id, label: 'Responsible', as: :select, collection: proc { User.all.order('first_name, last_name').map{|p| [p.full_name, p.id]} }
  filter :updated_at
  filter :customers_type, as: :select, collection: Company.customers_types.to_a.map{|u| [u[1], u[0]]}

  form do |f|
    f.inputs do
      f.input :name
      f.input :responsible_id, label: 'Responsible', as: :select, collection: company.users.order('first_name, last_name').map{|p| [p.full_name, p.id]}
      f.input :timezone, as: :time_zone, label: 'Time Zone', priority_zones: ActiveSupport::TimeZone.us_zones
      f.input :customers_type, as: :select, collection: Company.customers_types.to_a.map{|u| [ ( u[1] == 'regular' ? 'client' : u[1]) , u[0] ]}  
    end
    f.actions
  end

  member_action :users do
    @company = Company.find(params[:id])
  end

  member_action :save_users, method: :post do
    company = Company.find(params[:id])
    company.user_ids = params[:company][:user_ids]
    redirect_to admin_company_path(params[:id])
  end
end
