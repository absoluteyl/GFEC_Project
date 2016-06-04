require 'test_helper'

class ListingMerchandisesTest < ActionDispatch::IntegrationTest

    test 'return list of all merchandises' do
        get '/api/merchandises'
        assert response.success?
        refute_empty response.body
    end
    
    test 'returns merchandises filtered by price' do
        phone = Merchandise.create!(title: 'iPhone6s', description: 'silver, 64g', price: 20000, amount: 1, user_id: 1)
        coffee = Merchandise.create!(title: 'coffeebean', description: '500g/pack, blue mountain', price: 680, amount: 1, user_id: 1)
        
        get '/api/merchandises?price=20000'
        assert_equal 200, response.status
        
        merchandises = JSON.parse(response.body, symbolize_names: true)
        titles = merchandises.collect{ |m| m[:title]}
        assert_includes titles, 'iPhone6s'
        refute_includes titles, 'coffeebean'
    end
    
    test 'returns merchandise by id' do
       merchandise = Merchandise.create!(title: 'iPhone6s', description: 'silver, 64g', price: 20000, amount: 1, user_id: 1)
       get "/api/merchandises/#{merchandise.id}"
       assert_equal 200, response.status
       
       merchandise_response = json(response.body)
       assert_equal merchandise.title, merchandise_response[:title]
    end
end