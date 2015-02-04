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
        :phone => params[:phone])
    binding.pry
    @person.save

    redirect "/person/all"

  end

  get '/:id' do
    @person = Person.find(params[:id])
    render "people/person"
  end

end