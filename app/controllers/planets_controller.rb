class PlanetsController < ApplicationController
	def show
		@aux2 = params[:id]
		@planeta = HTTParty.get('https://swapi.co/api/planets/' + @aux2 + '/', :headers => {'Content-Type' => 'application/json'})
		@cantidad_residentes = @planeta['residents'].length - 1
		@lista_residentes = []
	    for i in 0..@cantidad_residentes do 	 	
	    	@residente = HTTParty.get(@planeta['residents'][i], :headers => {'Content-Type' => 'application/json'})
	 		@lista_residentes.push(@residente)
	 	end
	 	@cantidad_films = @planeta['films'].length - 1
	 	@lista_films = []
	    for i in 0..@cantidad_films do 	 	
	    	@film = HTTParty.get(@planeta['films'][i], :headers => {'Content-Type' => 'application/json'})
	 		@lista_films.push(@film)
		end
	end
end
