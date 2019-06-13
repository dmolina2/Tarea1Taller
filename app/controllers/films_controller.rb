
require 'json'
require "graphql/client"
require "graphql/client/http"



class FilmsController < ApplicationController
	include HTTParty
	attr_accessor :auxiliar
	# Star Wars API example wrapper
	module SWAPI
	  # Configure GraphQL endpoint using the basic HTTP network adapter.
	  HTTP = GraphQL::Client::HTTP.new("https://swapi-graphql-integracion-t3.herokuapp.com/")
	  
	  # Fetch latest schema on init, this will make a network request
	  Schema = GraphQL::Client.load_schema(HTTP)

	  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
	 end
	
	AllFilmQuery = SWAPI::Client.parse <<-'GRAPHQL'
		  query {
	       allFilms {
	       	films {
	       	 id
	         title
	         releaseDate
	         producers
	         episodeID
	         director
	       	}
	       }
	  	  }
		GRAPHQL

	def index
		#@response = HTTParty.get('https://swapi.co/api/films/', :headers => {'Content-Type' => 'application/json'})
		@result1 = SWAPI::Client.query(AllFilmQuery)
	end

	FilmQuery = SWAPI::Client.parse <<-'GRAPHQL'
	  query($id: ID!) {
	   	film(id: $id) {
	   	 id
	     title
	     releaseDate
	     producers
	     episodeID
	     director
	     characterConnection{
	     	characters{
	     		id
	     		name
	     	}
	     }
	     planetConnection{
	     	planets{
	     		id
	     		name
	     	}
	     }
	     starshipConnection{
	     	starships{
	     		id
	     		name
	     	}
	     }
	   	}
  	  }
	GRAPHQL

	def show
		@response3 = SWAPI::Client.query(FilmQuery, variables: { id: params[:id] })
	end

	def new
	end
		
end



 