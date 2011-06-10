# coding: utf-8
class Deal < ActiveRecord::Base
  belongs_to :user

  validates :price,       :presence => true
  validates :description, :presence => true
  validates :link,        :presence => true
  validates :type,        :presence => true

  TYPES = ["Bebidas", "Beleza e Saúde", "Celulares e Telefones", "DVDs e CDs", "Eletrodomésticos", "Eletrônicos", "Esportes e Lazer", "Informática", "Livros", "Roupas e Calçados", "Viagens"]
end
