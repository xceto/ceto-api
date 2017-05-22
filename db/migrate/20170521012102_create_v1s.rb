class CreateV1s < ActiveRecord::Migration[5.1]
  def change
    create_table :v1s do |t|
      t.integer :folio
      t.integer :monto
      t.string :rut_pagador
      t.string :rut_cedido
      t.string :estado

      t.timestamps
    end
  end
end
