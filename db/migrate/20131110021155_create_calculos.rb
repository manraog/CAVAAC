class CreateCalculos < ActiveRecord::Migration
  def change
    create_table :calculos do |t|
      t.float :perdida_persion
      t.float :diametro_cilindro
      t.float :velocidad_cilindro
      t.float :presion_trabajo
      t.float :diametro_tubo

      t.timestamps
    end
  end
end
