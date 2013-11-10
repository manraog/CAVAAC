class ChangeTypeDiametroTubo < ActiveRecord::Migration
 def up
    change_table :calculos do |t|
      t.change :diametro_tubo, :string
    end
  end

  def down
    change_table :calculos do |t|
      t.change :diametro_tubo, :integer
    end
  end
end
