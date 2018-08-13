class AddPas < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pas, :string
  end
end
