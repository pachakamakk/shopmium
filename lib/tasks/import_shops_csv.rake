require 'csv'

namespace :import_shops_csv do
  task :create_shops => :environment do
    puts('Starting import script. Please wait.')
    csv_text = File.read('lib/assets/shops_shopmium.csv')
    i = 0;
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |unstriped_row|
      row = {}
      unstriped_row.each{|k, v| row[k.strip] = v}
      Shop.create!({ "name" => row.to_hash['name'], "chain" => row.to_hash['chain'], "latitude" => row.to_hash['latitude'], "longitude" => row.to_hash['longitude'], "city" => row.to_hash['city'], "zip" => row.to_hash['zip'], "address" => row.to_hash['address'], "phone" => row.to_hash['phone'], "country_code" => row.to_hash['country_code']})
    end
    puts('Done')
  end
end
