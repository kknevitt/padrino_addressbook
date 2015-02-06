require 'pry'
require 'sinatra/flash'

AddressBook::App.controllers :people do

 # edit path to use members only in protected paths
  before /.*\/[0-9]+/ do
    unless session[:logged_in] || request.path.start_with?('/people/login') || request.path.start_with?('/people/signup')
      flash[:notice] = "Not logged in"
      redirect "/people/login"
    else
      @person = Person.find(params[:id])
    end
  end

  get '/edit_type_preferences/:id' do
    render "people/preferences"
  end

  post '/edit_type_preferences/:id' do
    @person.update(params[:person])
    redirect 'people/all'
  end

  get '/login' do
    render "people/login"
  end

  get '/signup' do
    render 'people/signup'
  end

  get '/members_only' do
      "Secret Stuff"
  end

  post '/login' do
    if User.where(:user_name=>params[:user_name]).exists?
      @user = User.find_by_user_name(params[:user_name])
      if @user.password == params[:password]
        flash[:notice] = "Welcome Back #{@user.user_name}"
        session[:logged_in] = true
        redirect 'people/all'
      else
        flash[:notice] = "Password not recognised"
        redirect 'people/login'
      end
    else
      flash[:notice] = "No such user"
      redirect 'people/login'
    end
  end


  get '/all' do
    @people = Person.all
    render "people/homepage"
  end

  get '/new' do
    @person = Person.new(:first_name => "first name")
  render "people/new"
  end

  post '/create' do

    @person = Person.new(params[:person])
    @person.save

    redirect "/people/all"

  end

  post '/surname/' do
    # @all_people = Person.all
    # @with_surname = @all_people.select do |person|
    #  person.last_name.start_with? params[:letter]
    # end

    # refactor to put this functionality in Person model
    # letter = "#{:letter}"
  @people = Person.where('last_name LIKE ?', "#{params[:surname]}%");
    render "people/search_results"
  end

  post '/delete/:id' do
    @person.destroy
    redirect 'people/all'
  end

  get '/edit/:id' do
    render "people/edit"
  end
  post '/update/:id' do
    @person.update(params[:person])
    redirect 'people/all'
  end

  get '/:id' do
    render "people/person"
  end

end