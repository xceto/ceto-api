class Api::V1Controller < ApplicationController
	respond_to :json

	def index
		opcion = params['bandera']
		fecha_buscar_desde = params['desde']
		fecha_buscar_hasta = params['hasta']
		estado_buscar = params['estado']

		case opcion
		when '1'
			unless fecha_buscar_desde.nil? || fecha_buscar_hasta.nil? || estado_buscar.nil?
				if estado_buscar == 'todo'
					resultado = V1.where("created_at >= ? AND created_at <= ?","#{fecha_buscar_desde} 00:00:00","#{fecha_buscar_hasta} 23:59:59")
				else
					resultado = V1.where("created_at >= ? AND created_at <= ? AND estado = ?","#{fecha_buscar_desde} 00:00:00","#{fecha_buscar_hasta} 23:59:59",estado_buscar)
				end

				if resultado.blank?
					render :json => 'No se encontraron resultados'
				else
					render :json => resultado
				end
			else
				render :json => "Debe contener los campos solicitados"
			end
		when '2'
			render :json => V1.where("updated_at >= ? AND updated_at <= ?",Time.now-1.month,Time.now), callback: params[:callback]
		when '3'
			render :json => V1.where(estado: 'cedida'), callback: params[:callback]
		else
 			render :json => V1.order('id'), callback: params[:callback]
		end
	end
end