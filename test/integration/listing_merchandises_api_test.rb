require 'test_helper'

class ListingMerchandisesApiTest < ActionDispatch::IntegrationTest

    test 'return list of all merchandises' do
        get '/api/merchandises?api_key=4484c065f013c7ff144f5c618fa8f341'
        assert response.success?
        refute_empty response.body
    end
    
    test 'returns merchandises filtered by price' do
        phone = Merchandise.create!(title: 'iPhone6s', description: 'silver, 64g', price: 20000, amount: 1, user_id: 1)
        coffee = Merchandise.create!(title: 'coffeebean', description: '500g/pack, blue mountain', price: 680, amount: 1, user_id: 1)
        
        get '/api/merchandises?api_key=4484c065f013c7ff144f5c618fa8f341&price=20000'
        assert_equal 200, response.status
        
        http_response = json(response.body)
        merchandises = http_response[:merchandises]
        titles = merchandises.collect{ |m| m[:title]}
        assert_includes titles, 'iPhone6s'
        refute_includes titles, 'coffeebean'
    end
    
    test 'returns merchandise by id' do
       merchandise = Merchandise.create!(title: 'iPhone6s', description: 'silver, 64g', price: 20000, amount: 1, user_id: 1)
       get "/api/merchandises/#{merchandise.id}?api_key=4484c065f013c7ff144f5c618fa8f341"
       assert_equal 200, response.status
       
       http_response = json(response.body)
       merchandise_response = http_response[:merchandise]
       assert_equal merchandise.title, merchandise_response[:title]
    end
end