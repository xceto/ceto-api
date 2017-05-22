class DashboardController < ApplicationController

	def index
		
		busqueda = ""
		bandera = "2"

		if params['/dashboard'].present? && params['/dashboard']['estado'].present? && params['/dashboard']['desde'].present? && params['/dashboard']['hasta'].present?
		 bandera = "1"
		 busqueda = "&estado=#{params['/dashboard']['estado']}&desde=#{params['/dashboard']['desde']}&hasta=#{params['/dashboard']['hasta']}"	
		end

	@resultado_json = JSON.parse(open("https://sleepy-reaches-57394.herokuapp.com/api/v1?bandera=#{bandera}"+busqueda).read)

	end

	def new
		revisa_cedidos = JSON.parse(open("https://sleepy-reaches-57394.herokuapp.com/api/v1?bandera=3").read)
		revisa_cedidos.each do |verifica|
		 	revisa_existencia = Dashboard.exists?(:folio => verifica['folio'])

			if revisa_existencia == false
				 Dashboard.create(folio: verifica['folio'], monto: verifica['monto'],rut_pagador: verifica['rut_pagador'],
					rut_cedido: verifica['rut_cedido'], estado: verifica['estado'], fecha_creacion: verifica['created_at'], fecha_update: verifica['updated_at'])
				flash[:notice] = "Guardados Correctamente"
			else
				flash[:notice] = "No hay nuevos datos"
			end
	  end
	  redirect_to action: "index"
	end

	def show
		@cesiones_cedidas = Dashboard.all.order(:created_at)
	end

	def buscador
		byebug
	end

end