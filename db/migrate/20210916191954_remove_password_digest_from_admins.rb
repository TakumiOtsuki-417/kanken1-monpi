class RemovePasswordDigestFromAdmins < ActiveRecord::Migration[6.0]
  def change
    remove_column :admins, :password_digest, :string
  end
end
