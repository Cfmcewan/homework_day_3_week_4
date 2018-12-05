require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('./models/pizza_order.rb')
also_reload('./models/*')

#read

get '/pizzas' do
  @orders = PizzaOrder.all()
  erb(:index)
end

#new - show form to create a new pizza

get '/pizzas/new' do
erb(:new)
end

get '/pizzas/:id' do
  @order = PizzaOrder.find(params[:id].to_i())
  erb(:show)
end

#create - save to the database

post '/pizzas' do
  @order = PizzaOrder.new(params)
  @order.save()
# redirect('/pizzas')
  erb(:create)
end

#Delete
post '/pizzas/:id/delete' do
  order = PizzaOrder.find(params[:id].to_i())
  order.delete()
  redirect('/pizzas')
end

#edit
get '/pizzas/:id/edit' do
  @order = PizzaOrder.find(params[:id].to_i())
  @toppings = ["Pepperoni", "Calzone", "Italian Sausage"]
  erb(:edit)
end

post '/pizzas/:id' do
  @order = PizzaOrder.new(params)
  @order.update()
  redirect('/pizzas')
end
