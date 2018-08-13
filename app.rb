
require 'sinatra'
require "sinatra/activerecord"
require "sinatra/reloader"
require './models/user'
require './models/post'
# require "./models/score"



set :database, {adapter: "postgresql",database: "crypto"} 




get "/" do 
 erb :homepage
end



# get "/" do 
#     # @skater = Skater.all
#     # erb :skaters
# end

get "/user/:id" do

@user = User.find(params[:id])
@post = @user.posts
erb :userid

end

get "/post/:id" do

  @post = Post.find(params[:id])
  erb :postid
  # render :layout => "l"
  end
get "/post" do

  @all_article = Post.all
  erb :all_article
  
  
end

get "/post/new" do
  
  erb :newform
end

post "/post" do
  
  Post.create(title: params[:title], post: params[:post])
  redirect "/post"

end


get "/post/:id/edit" do
  @curent_post = Post.find(params[:id])
  erb :edit_post
end

put  "/post/:id" do

@curent_post = Post.find(params[:id])
@curent_post.update(title: params[:title], post: params[:post])
redirect "/post"
end

delete  "/post/:id" do

  @curent_post = Post.find(params[:id])
  @curent_post.destroy
  redirect "/post"
  end
  


 get  "/login" do 

  erb :login
 end
 

 get  "/register" do 

  erb :register
 end
 # get "/dogs/:id" do
#   @specific_dog = Dog.find(params[:id])
#   erb :show_dog
# end





# post "/dogs" do 
#   # Dog.create(name: params[:name],breed: params[:breed],age: params[:age])
#   # redirect "/dogs"
# end

# get "/dogs/new" do
 
#   # erb :newdog
# end

# # edit 

# get "/dogs/:id/edit" do
#   # @dog = Dog.find(params[:id])


#   erb :edit
# end

# # update 

# put "/dogs/:id" do
# # @curent_dog = Dog.find(params[:id])
# # @curent_dog.update(name: params[:name],breed: params[:breed],age: params[:age])
# # redirect "/dogs"
# end

# delete "/dogs/:id" do 
# # @curent_dog = Dog.find(params[:id])
# # @curent_dog 
# # redirect "/dogs"
# end




# get "/owners:id"
# @owner = params[:id]
# @specific_owner = Owner.find(params[:id])
# @owners_dogs = @specific_owner.dogs
# erb :ownerid
# end

# get "/random"
# random_name = ['asdasd','dasd','vodka']
# random_breed = ["name",'pop']
# Dog.create(name: random_name, breed: random_breed, age: 20)
# end