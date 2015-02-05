require 'pry'
require 'sinatra/flash'

AddressBook::App.controllers :person do

  set :members, {}

configure do
    settings.members["kknevitt"] = {
      :password => "password"
    }
  end

  before do

    unless session[:logged_in] || request.path.start_with?('/person/login') || request.path.start_with?('/person/signup')
      flash[:notice] = "Not logged in"
      redirect "/person/login"
    end
  end


  get '/login' do
    #html form
    render "people/login"
  end

  get '/signup' do
    render 'people/signup'
  end

  get '/members_only' do
      "Secret Stuff"
  end

  post '/login' do
    # assuming username is passed in params, and is the same as key in members

    if User.where(:user_name=>params[:user_name]).exists?
      @user = User.find_by_user_name(params[:user_name])
      if @user.password == params[:password]

        flash[:notice] = "Welcome Back #{@user.user_name}"
        session[:logged_in] = true
        redirect 'person/all'
      else

        flash[:notice] = "Password not recognised"
        redirect 'person/login'
      end

    else
      flash[:notice] = "No such user"
      redirect 'person/login'
    end

  end


  get '/all' do
    @people = Person.all
    render "people/homepage"
  end

  get '/new' do
  render "people/new"
  end

  post '/create' do
    @person = Person.new(:first_name => params[:first_name],
     :last_name => params[:last_name],
      :email => params[:email],
       :twitter => params[:twitter],
        :phone => params[:phone],
        :role => params[:role])
    @person.save

    redirect "/person/all"

  end

  get '/surname/:letter' do
    @all_people = Person.all
    @with_surname = @all_people.select do |person|

     person.last_name.start_with? params[:letter]
    end
    # refactor to put this functionality in Person model?
    # letter = :letter
    # @people = Person.where('last_name LIKE ?', "%#{letter}%");

    render "people/search_results"
  end

  post '/delete/:id' do
    @person = Person.find(params[:id])
    @person.destroy
    redirect 'person/all'
  end

  get '/edit/:id' do
    @person = Person.find(params[:id])
    render "people/edit"
  end

  post '/update/:id' do
    @person = Person.find(params[:id])
    @person.update(params)
    redirect 'person/all'
  end


  get '/:id' do
    @person = Person.find(params[:id])
    render "people/person"
  end




end