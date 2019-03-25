
require 'json'
class FilmsController < ApplicationController
	include HTTParty
	attr_accessor :auxiliar
	def index
		@response = HTTParty.get('https://swapi.co/api/films/', :headers => {'Content-Type' => 'application/json'})
		@response1 = JSON.parse(@response.body)
	end

	def show
		if params[:id] == '4'
			@aux = '1'
		elsif params[:id] == '5'
			@aux = '2'
		elsif params[:id] == '6'
			@aux = '3'
		elsif params[:id] == '1'
			@aux = '4'
		elsif params[:id] == '2'
			@aux = '5'
		elsif params[:id] == '3'
			@aux = '6'
		else
			@aux = '7'
		end
		@response2 = HTTParty.get('https://swapi.co/api/films/' + @aux + '/', :headers => {'Content-Type' => 'application/json'})
		@indices_personajes = []
		@indices_planetas = []
		@indices_naves = []
		@cantidad_personajes = @response2['characters'].length - 1
		@lista_personajes = []
	    for i in 0..@cantidad_personajes do 	 	
	    	@prueba = HTTParty.get(@response2['characters'][i], :headers => {'Content-Type' => 'application/json'})
	 		@lista_personajes.push(@prueba)
	 		@id_personaje = @prueba['url'].to_s.split('/')[-1]
	 		@indices_personajes.push(@id_personaje)
	 	end
		@cantidad_planetas = @response2['planets'].length - 1
		@lista_planetas = []
		for i in 0..@cantidad_planetas do 	 	
	    	@prueba1 = HTTParty.get(@response2['planets'][i], :headers => {'Content-Type' => 'application/json'})
	 		@lista_planetas.push(@prueba1)	
	 		@id_planeta = @prueba1['url'].to_s.split('/')[-1]
	 		@indices_planetas.push(@id_planeta)
	 	end
	 	@cantidad_naves = @response2['starships'].length - 1
		@lista_naves = []
		for i in 0..@cantidad_naves do 	 	
	    	@prueba2 = HTTParty.get(@response2['starships'][i], :headers => {'Content-Type' => 'application/json'})
	 		@lista_naves.push(@prueba2)
	 		@id_nave = @prueba2['url'].to_s.split('/')[-1]
	 		@indices_naves.push(@id_nave)
	 	end

		
	end
	def new
		@busqueda = params[:id]

		@peliculas = HTTParty.get('https://swapi.co/api/films/', :headers => {'Content-Type' => 'application/json'})
		@cantidad_peliculas = @peliculas.length - 1
		for i in 0..@cantidad_peliculas do
			@buscar = @peliculas['results'][i]['title']
			if @buscar == @busqueda
				@id_pelicula = @peliculas['results'][i]['url'].to_s.split('/')[-1]
				if @id_pelicula == '4'
					@id_pelicula = '1'
				elsif @id_pelicula == '5'
					@id_pelicula = '2'
				elsif @id_pelicula == '6'
					@id_pelicula = '3'
				elsif @id_pelicula == '1'
					@id_pelicula = '4'
				elsif @id_pelicula == '2'
					@id_pelicula = '5'
				elsif @id_pelicula == '3'
					@id_pelicula = '6'
				else
					@id_pelicula = '7'
				end 
				redirect_to :controller => 'films', :action => 'show', :id => @id_pelicula 
			end
		end

		@naves0 = HTTParty.get('https://swapi.co/api/starships/', :headers => {'Content-Type' => 'application/json'})
		@naves1 = HTTParty.get('https://swapi.co/api/starships/?page=2', :headers => {'Content-Type' => 'application/json'})
		@naves2 = HTTParty.get('https://swapi.co/api/starships/?page=3', :headers => {'Content-Type' => 'application/json'})
		@naves3 = HTTParty.get('https://swapi.co/api/starships/?page=4', :headers => {'Content-Type' => 'application/json'})
		@lista_todas_naves = @naves0['results'] | @naves1['results'] | @naves2['results'] | @naves3['results']
		@cantidad_naves = @lista_todas_naves.length - 1
		for i in 0..@cantidad_naves do
			@buscar1 = @lista_todas_naves[i]['name']
			if @buscar1 == @busqueda
				@id_nave = @lista_todas_naves[i]['url'].to_s.split('/')[-1]
				redirect_to :controller => 'starships', :action => 'show', :id => @id_nave
			end
		end

		@personajes0 = HTTParty.get('https://swapi.co/api/people/', :headers => {'Content-Type' => 'application/json'})
		@personajes1 = HTTParty.get('https://swapi.co/api/people/?page=2', :headers => {'Content-Type' => 'application/json'})
		@personajes2 = HTTParty.get('https://swapi.co/api/people/?page=3', :headers => {'Content-Type' => 'application/json'})
		@personajes3 = HTTParty.get('https://swapi.co/api/people/?page=4', :headers => {'Content-Type' => 'application/json'})
		@personajes4 = HTTParty.get('https://swapi.co/api/people/?page=5', :headers => {'Content-Type' => 'application/json'})
		@personajes5 = HTTParty.get('https://swapi.co/api/people/?page=6', :headers => {'Content-Type' => 'application/json'})
		@personajes6 = HTTParty.get('https://swapi.co/api/people/?page=7', :headers => {'Content-Type' => 'application/json'})
		@personajes7 = HTTParty.get('https://swapi.co/api/people/?page=8', :headers => {'Content-Type' => 'application/json'})
		@personajes8 = HTTParty.get('https://swapi.co/api/people/?page=9', :headers => {'Content-Type' => 'application/json'})
		@lista_todos_personajes = @personajes0['results'] | @personajes1['results'] | @personajes2['results'] | @personajes3['results'] | @personajes4['results'] | @personajes5['results'] | @personajes6['results'] | @personajes7['results'] | @personajes8['results']
		@cantidad_personajes = @lista_todos_personajes.length - 1
		for i in 0..@cantidad_personajes do
			@buscar2 = @lista_todos_personajes[i]['name']
			if @buscar2 == @busqueda
				@id_personaje = @lista_todos_personajes[i]['url'].to_s.split('/')[-1]
				redirect_to :controller => 'characters', :action => 'show', :id => @id_personaje
			end
		end

		@planetas0 = HTTParty.get('https://swapi.co/api/planets/', :headers => {'Content-Type' => 'application/json'})
		@planetas1 = HTTParty.get('https://swapi.co/api/planets/?page=2', :headers => {'Content-Type' => 'application/json'})
		@planetas2 = HTTParty.get('https://swapi.co/api/planets/?page=3', :headers => {'Content-Type' => 'application/json'})
		@planetas3 = HTTParty.get('https://swapi.co/api/planets/?page=4', :headers => {'Content-Type' => 'application/json'})
		@planetas4 = HTTParty.get('https://swapi.co/api/planets/?page=5', :headers => {'Content-Type' => 'application/json'})
		@planetas5 = HTTParty.get('https://swapi.co/api/planets/?page=6', :headers => {'Content-Type' => 'application/json'})
		@planetas6 = HTTParty.get('https://swapi.co/api/planets/?page=7', :headers => {'Content-Type' => 'application/json'})
		@lista_todos_planetas = @planetas0['results'] | @planetas1['results']  | @planetas2['results']  | @planetas3['results']  | @planetas4['results']  | @planetas5['results']  | @planetas6['results']  
		@cantidad_planetas = @lista_todos_planetas.length - 1
		for i in 0..@cantidad_planetas do
			@buscar3 = @lista_todos_planetas[i]['name']
			if @buscar3 == @busqueda
				@id_planeta = @lista_todos_planetas[i]['url'].to_s.split('/')[-1]
				redirect_to :controller => 'planets', :action => 'show', :id => @id_planeta
			end
		end
	end
end



 