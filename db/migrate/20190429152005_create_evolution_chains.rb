class CreateEvolutionChains < ActiveRecord::Migration[5.2]
  def change
    create_table :evolution_chains do |t|
      
      t.timestamps
    end
  end
end
