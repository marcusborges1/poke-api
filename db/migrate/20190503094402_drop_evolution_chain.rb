class DropEvolutionChain < ActiveRecord::Migration[5.2]
  def change
    drop_table :evolution_chains do |t|
      
      t.timestamps
    end
  end
end
