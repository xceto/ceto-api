class DashboardController < ApplicationController

	def index
		resultado = JSON.parse(open("http://localhost:3000/api/v1?bandera=2").read)
		@resultado_json = resultado


	end

	def new

		revisa_cedidos = JSON.parse(open("http://localhost:3000/api/v1?bandera=3").read)

		revisa_cedidos.each do |verifica|
		 	revisa_existencia = Dashboard.exists?(:folio => verifica['folio'])

			if revisa_existencia == false
				 Dashboard.create(folio: verifica['folio'], monto: verifica['monto'],rut_pagador: verifica['rut_pagador'],
					rut_cedido: verifica['rut_cedido'], estado: verifica['estado'], fecha_creacion: verifica['created_at'], fecha_update: verifica['updated_at'])
			else
				puts "ya existe"
			end
	  end
	  render :show
	end

	def show
		@cesiones_cedidas = Dashboard.all.order(:created_at)
	end


end