class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    if !params[:owner_name].empty?
      pet = Pet.create(:name => params[:pet_name], :owner_id => Owner.create(name: params[:owner_name]).id)
    else
      pet = Pet.create(:name => params[:pet_name], :owner_id => params[:owner])
    end  
    redirect "/pets/#{pet.id}"
  end

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    pet = Pet.find_by(params[:id])
    if !params[:owner_name].empty?
      pet.update(:name => params[:pet_name], :owner_id => Owner.create(name: params[:owner_name]).id)
    else
      pet.update(:name => params[:pet_name], :owner_id => params[:owner][:name])
    end 
    pet.save 

    redirect to "pets/#{@pet.id}"
  end
end