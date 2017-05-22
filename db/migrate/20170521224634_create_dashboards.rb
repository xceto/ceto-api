class CreateDashboards < ActiveRecord::Migration[5.1]
  def change
    create_table :dashboards do |t|
      t.integer :folio
      t.integer :monto
      t.string :rut_pagador
      t.string :rut_cedido
      t.string :estado
      t.date :fecha_creacion
      t.date :fecha_update
      t.timestamps
    end
  end
end
