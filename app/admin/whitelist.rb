ActiveAdmin.register Whitelist do
  permit_params :name, :company_id,
  ips_attributes: [:address, :_destroy, :id]

  show do
    attributes_table do
        row :name
        row :company
        row :created_at

        panel "IP addresses allowed" do
            table_for whitelist.ips do
              column :address
            end
        end
    end
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs do
      f.input :name
      f.input :company_id, :as => :hidden, input_html: { value: current_user.company.id }
      f.inputs do
        f.has_many :ips, allow_destroy: true, heading: 'Ip Address' do |a|
          a.input :address
        end
      end
    end

    f.actions
  end

end
