
require 'sinatra'
require "sinatra/activerecord"
require "sinatra/reloader"
require "sinatra/flash"
require './models/user'
require './models/post'
# require "./models/score"

enable :sessions

set :database, {adapter: "postgresql",database: "crypto"} 




 

get "/" do
  if session[:user_id]
    erb :all_article
  else
    erb :homepage, :layout => :outlayout
  end
end




 
get "/login" do
   
  erb :login, :layout => :outlayout
end

post "/login" do
  @user = User.find_by(email: params[:email])

  # checks to see if the user exists
  #   and also if the user password matches the password in the db
  if @user && @user.pas == params[:password]
    # this line signs a user in
    session[:user_id] = @user.id

    # lets the user know that something is wrong
    flash[:info] = "You have been signed in"

    # redirects to the home page
    redirect "/post"
  else
    # lets the user know that something is wrong
    flash[:warning] = "Your username or password is incorrect"

    # if user does not exist or password does not match then
    #   redirect the user to the sign in page
    redirect "/login"
  end
end

 

 get  "/register" do 
  
  erb :register, :layout => :outlayout
 end

 post "/register" do
  User.create(first_name: params[:first_name], last_name: params[:last_name],email: params[:email],birthday: params[:birthday],pas: params[:password] )
  redirect "/login"
end



get "/logout" do
  # this is the line that signs a user out
  session[:user_id] = nil

  # lets the user know they have signed out
  flash[:info] = "You have been signed out"
  
  redirect "/"
end

get "/post/new" do
  if session[:user_id]
  erb :newform
  else
    flash[:warning] = "Sign-in please"
    erb :login
  end
end

post "/post" do
  if session[:user_id]
  Post.create(title: params[:title], post: params[:post])
  redirect "/post"
  else
    flash[:warning] = "Sign-in please"
    erb :login
  end

end
get "/user/:id" do
  if session[:user_id]
    @user = User.find(params[:id])
    @post = @user.posts
erb :userid
  else
    flash[:warning] = "Sign-in please"
    erb :login
  end
end

get "/post/:id" do
  if session[:user_id]
  @post = Post.find(params[:id])
  @user = Post.find(@post.id).User
  erb :postid
  else
    flash[:warning] = "Sign-in please"
    erb :login
  end
  # render :layout => "l"
end

get "/post" do
  if session[:user_id]
  @all_article = Post.all
  erb :all_article
  else
    flash[:warning] = "Sign-in please"
    erb :login
  end
  
end




get "/post/:id/edit" do
  if session[:user_id]
  @curent_post = Post.find(params[:id])
  erb :edit_post
  else
    flash[:warning] = "Sign-in please"
    erb :login
  end
end

put  "/post/:id" do
  
  if session[:user_id]
@curent_post = Post.find(params[:id])
@curent_post.update(title: params[:title], post: params[:post])
redirect "/post"
  else
    flash[:warning] = "Sign-in please"
    erb :login
  end
end

delete  "/post/:id" do
  if session[:user_id]
  @curent_post = Post.find(params[:id])
  @curent_post.destroy
  redirect "/post"
  else
    flash[:warning] = "Sign-in please"
    erb :login
  end
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