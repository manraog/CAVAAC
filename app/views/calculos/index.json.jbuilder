json.array!(@calculos) do |calculo|
  json.extract! calculo, :perdida_persion, :diametro_cilindro, :velocidad_cilindro, :presion_trabajo, :diametro_tubo
  json.url calculo_url(calculo, format: :json)
end
