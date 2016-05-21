class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |t|
      t.string :chain
      t.string :name
      t.string :latitude
      t.string :longitude
      t.string :address
      t.string :city
      t.string :zip
      t.string :phone
      t.string :country_code

      t.timestamps null: false
      geocoded_by :full_street_address   # can also be an IP address
      after_validation :geocode
      end
  end
end
