class AddBusinessCoverImageToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :caterer_business_cover_image, :string
  end
end
