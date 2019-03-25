class StarshipsController < ApplicationController
	def show
		@aux3 = params[:id]
		@nave = HTTParty.get('https://swapi.co/api/starships/' + @aux3 + '/', :headers => {'Content-Type' => 'application/json'})
		
		@cantidad_pilotos = @nave['pilots'].length - 1
		@lista_pilotos = []
	    for i in 0..@cantidad_pilotos do 
	    	@piloto= HTTParty.get(@nave['pilots'][i], :headers => {'Content-Type' => 'application/json'})
	    	@lista_pilotos.push(@piloto)
	 	end
	 	@cantidad_filmss = @nave['films'].length - 1
	 	@lista_filmss = []
	    for i in 0..@cantidad_filmss do 	 	
	    	@film = HTTParty.get(@nave['films'][i], :headers => {'Content-Type' => 'application/json'})
	 		@lista_filmss.push(@film)
		end
	end
end
