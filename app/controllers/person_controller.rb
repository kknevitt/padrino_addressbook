require 'pry'
require 'sinatra/flash'

AddressBook::App.controllers :people, :map=>"person" do

 # edit path to use members only in protected paths
  before /.*\/[0-9]+/ do
    unless session[:logged_in] || request.path.start_with?('/people/login') || request.path.start_with?('/people/signup')
      flash[:notice] = "Not logged in"
      redirect url_for(:people, :login)
    else
      # need to filter members only for this to work.
      # @person = Person.find(params[:id])
    end
  end

  get :index do
    @people = Person.all
    render "people/homepage"
  end

  get :new do
  render "people/new"
  end

  post :create do
    @person = Person.new(params[:person])
    @person.save
    redirect url_for(:people, :index)
  end

  delete :delete, :map => ":id" do
    @person.destroy
    redirect url_for(:people, :index)
  end

  get :edit, :map => ":id/edit" do
    @person = Person.find(params[:id])
    render "people/edit"
  end

  put :update, :map => ":id" do
    @person = Person.find(params[:id])
    person = params[:trainee] || params[:instructor]
    @person.update(person)
    redirect url_for(:people, :index)
  end

  get :role_preferences, :map => ":id/role_preferences" do
    render "people/preferences"
  end

  put :role_preferences, :map => ":id/" do
    @person = Person.find(params[:id])
    @person.update(params[:person])
    redirect url_for(:people, :index)
  end

  post :surname do
    @people = Person.where('last_name LIKE ?', "#{params[:surname]}%");
    render "people/search_results"
  end

  get :login, :map => "login" do
    render "people/login"
  end

  post :login do
    if User.where(:user_name=>params[:user_name]).exists?
      @user = User.find_by_user_name(params[:user_name])
      if @user.password == params[:password]
        flash[:notice] = "Welcome Back #{@user.user_name}"
        session[:logged_in] = true
        redirect url_for(:people, :index)
      else
        flash[:notice] = "Password not recognised"
        redirect url_for(:people, :login)
      end
    else
      flash[:notice] = "No such user"
      redirect url_for(:people, :login)
    end
  end

  get :sign_up do
    render 'people/signup'
  end

  post :sign_up do
    @user = User.new(:user_name => params[:user_name], :password =>params[:password])
    @user.save
    redirect url_for(:people, :index)
  end

  get :index, :with => :id do
    @person = Person.find(params[:id])
    render "people/person"
  end

end