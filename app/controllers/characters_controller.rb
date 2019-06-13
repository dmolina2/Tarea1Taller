class CharactersController < ApplicationController
	# Star Wars API example wrapper
	module SWAPI
	  # Configure GraphQL endpoint using the basic HTTP network adapter.
	  HTTP = GraphQL::Client::HTTP.new("https://swapi-graphql-integracion-t3.herokuapp.com/")
	  
	  # Fetch latest schema on init, this will make a network request
	  Schema = GraphQL::Client.load_schema(HTTP)

	  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
	 end

	PersonQuery = SWAPI::Client.parse <<-'GRAPHQL'
	  query($id: ID!) {
	   	person(id: $id) {
	   	 id
	     name
	     height
	     birthYear
	     hairColor
	     eyeColor
	     skinColor
	     gender
	     mass
	     homeworld{
	     	id
	     	name
	     }
	     starshipConnection{
	     	starships{
	     		id
	     		name
	     	}
	     }
	     filmConnection{
	     	films{
	     		id
	     		title
	     	}
	     }
	   	}
  	  }
	GRAPHQL

	def show
		@response3 = SWAPI::Client.query(PersonQuery, variables: { id: params[:id] })
	end

end
