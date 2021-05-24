class AddSuperadmin < ActiveRecord::Migration[5.2]
    def change
        User.create! do |u|
            u.email     = 'admin@admin.com'
            u.password  = '123456'
            u.superadmin_role = true
            u.name = 'Admin'
        end
    end
end