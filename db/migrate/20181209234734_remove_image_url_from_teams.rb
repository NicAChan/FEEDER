class RemoveImageUrlFromTeams < ActiveRecord::Migration[5.2]
  def change
    remove_column :teams, :image_url, :string
  end
end
