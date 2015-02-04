require 'pry'

AddressBook::App.controllers :person do

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
      # binding.pry
     person.last_name.start_with? params[:letter]
    end

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