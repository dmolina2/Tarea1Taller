class CharactersController < ApplicationController
	def show
		@aux1 = params[:id]
		@personaje = HTTParty.get('https://swapi.co/api/people/' + @aux1 + '/', :headers => {'Content-Type' => 'application/json'})
		@procedencia = HTTParty.get(@personaje['homeworld'], :headers => {'Content-Type' => 'application/json'})
		@cantidad_peliculas = @personaje['films'].length - 1
		@lista_peliculas = []
	    for i in 0..@cantidad_peliculas do 	 	
	    	@pelicula = HTTParty.get(@personaje['films'][i], :headers => {'Content-Type' => 'application/json'})
	 		@lista_peliculas.push(@pelicula)
	 	end
	 	@cantidad_navess = @personaje['starships'].length - 1
	 	@lista_navess = []
	    for i in 0..@cantidad_navess do 	 	
	    	@nave = HTTParty.get(@personaje['starships'][i], :headers => {'Content-Type' => 'application/json'})
	 		@lista_navess.push(@nave)
		end
	end

end
