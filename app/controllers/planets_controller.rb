class PlanetsController < ApplicationController
	# Star Wars API example wrapper
	module SWAPI
	  # Configure GraphQL endpoint using the basic HTTP network adapter.
	  HTTP = GraphQL::Client::HTTP.new("https://swapi-graphql-integracion-t3.herokuapp.com/")
	  
	  # Fetch latest schema on init, this will make a network request
	  Schema = GraphQL::Client.load_schema(HTTP)

	  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
	 end

	PlanetQuery = SWAPI::Client.parse <<-'GRAPHQL'
	  query($id: ID!) {
	   	planet(id: $id) {
	   	 id
	     name
	     population
	     terrains
	     diameter
	     rotationPeriod
	     orbitalPeriod
	     gravity
	     surfaceWater
	     climates
	     residentConnection{
	     	residents{
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
		@response3 = SWAPI::Client.query(PlanetQuery, variables: { id: params[:id] })
	end
end
