require_relative('property_tracker')

property1 = Property.new({'value' => '500000', 'number_of_bedrooms' => '1', 'year_built' => '1600', 'buy_let_status' => 'For Let'})

property2 = Property.new({'value' => '250000', 'number_of_bedrooms' => '2', 'year_built' => '1950', 'buy_let_status' => "for sale"})


Property.delete_all()
property1.save
property1.value = 500
property1.update()
property2.save
Property.find_by_year_built(1600)
