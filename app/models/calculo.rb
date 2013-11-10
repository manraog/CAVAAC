class Calculo < ActiveRecord::Base
validates :perdida_persion, :diametro_cilindro, :velocidad_cilindro, :presence => {:message => "no puede estar vacio"}
validates :perdida_persion, :diametro_cilindro, :velocidad_cilindro, :numericality => {:message => "debe ser un numero"}

end
