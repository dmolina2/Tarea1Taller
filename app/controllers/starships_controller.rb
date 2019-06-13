class StarshipsController < ApplicationController
	# Star Wars API example wrapper
	module SWAPI
	  # Configure GraphQL endpoint using the basic HTTP network adapter.
	  HTTP = GraphQL::Client::HTTP.new("https://swapi-graphql-integracion-t3.herokuapp.com/")
	  
	  # Fetch latest schema on init, this will make a network request
	  Schema = GraphQL::Client.load_schema(HTTP)

	  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
	 end

	StarshipQuery = SWAPI::Client.parse <<-'GRAPHQL'
	  query($id: ID!) {
	   	starship(id: $id) {
	   		name
	   		model
	   		consumables
	   		starshipClass
	   		costInCredits
	   		length
	   		hyperdriveRating
	   		cargoCapacity
	   		crew
	   		passengers
	   		maxAtmospheringSpeed
	   		manufacturers
	   		filmConnection{
	   			films{
	   				id
	   				title
	   			}
	   		}
	   		pilotConnection{
	   			pilots{
	   				id
	   				name
	   			}
	   		}
	   	}
	   }
	GRAPHQL


	def show
		@response3 = SWAPI::Client.query(StarshipQuery, variables: { id: params[:id] })
	end
end
