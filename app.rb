
require 'sinatra'
require "sinatra/activerecord"
require "sinatra/reloader"
require "sinatra/flash"
require './models/user'
require './models/post'
# require "./models/score"

enable :sessions





 

get "/" do
  
    erb :homepage, :layout => :outlayout

end




 
get "/login" do
   
  erb :login, :layout => :outlayout
end

post "/login" do
  @user = User.find_by(email: params[:email])

  if @user && @user.pas == params[:password]
 
    session[:user_id] = @user.id 
    flash[:info] = "You have been signed in"

    
    redirect "/post"
  else
     
    flash[:warning] = "Your username or password is incorrect"
 
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


post "/post" do
  if session[:user_id]
   @user =  session[:user_id]
  Post.create(title: params[:title], post: params[:post],user_id: @user)

  redirect "/post"

  else
    flash[:warning] = "Sign-in please"
    
    redirect "/login"
  end

end

get "/user" do

  if session[:user_id]

    @user = User.find(session[:user_id])
    @post = @user.posts

    erb :userid

  else
    flash[:warning] = "Sign-in please"
    redirect "/login"
  end
end



delete  "/user/:id" do
   
  if session[:user_id]  
     
      get_current_user.destroy
      session[:user_id] = nil
    redirect "/"

    else

    flash[:warning] = "Sign-in please"
    erb :login

    end
  end

get "/post/:id" do
  if session[:user_id]
  @post = Post.find(params[:id])
  @user = Post.find(@post.id).user
  erb :postid
  else

    flash[:warning] = "Sign-in please"
    redirect "/login"

  end
  
end

get "/post" do
  if session[:user_id]
    @all_article = Post.all
  erb :all_article
  else
    flash[:warning] = "Sign-in please"
    redirect "/login"
  end
  
end




get "/post/:id/edit" do
 
  if session[:user_id]
    @post = Post.find(params[:id])
    @user = Post.find(@post.id).user
    if session[:user_id] == @user.id
  
    @curent_post = Post.find(params[:id])
  erb :edit_post
    else
      flash[:warning] = "access denied"
      redirect "/post"
  end

  else
    flash[:warning] = "Sign-in please"
    redirect "/login"
  end
end

put  "/post/:id" do
  
  if session[:user_id]
@curent_post = Post.find(params[:id])
@curent_post.update(title: params[:title], post: params[:post])
redirect "/post"
  else
    flash[:warning] = "Sign-in please"
    redirect "/login"
  end
end

delete  "/post/:id" do
  if session[:user_id]
  @curent_post = Post.find(params[:id])
  @curent_post.destroy
  redirect "/post"
  else
    flash[:warning] = "Sign-in please"
    redirect "/login"
  end
  end

  get "/allusers" do
 
    if session[:user_id]
      @count = 0;
     @all_users = User.all
    erb :all_users

    else
        flash[:warning] = "access denied"
        redirect "/post"
    end
  end


  get "/user/:id" do 
    if session[:user_id]
   
    @curent_user = User.find(params[:id])
    @curent_post = @curent_user.posts
    erb :user_posts
      else
        flash[:warning] = "Sign-in please"
        redirect "/login"
      end
    end
 
 
  def get_current_user 
    User.find(session[:user_id])
  end

