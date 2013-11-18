class Calculo < ActiveRecord::Base
validates :diametro_cilindro, :velocidad_cilindro, :presence => {:message => "no puede estar vacio"}
validates :perdida_persion, :diametro_cilindro, :velocidad_cilindro, :presion_trabajo, :numericality => {:message => "debe ser un numero"}
validates_inclusion_of :perdida_persion, :in => 0..1, :message => "=> Por ahora solo calculamos con presión maxima de 1 Bar"
end
