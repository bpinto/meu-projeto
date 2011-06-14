# coding: utf-8
class Deal < ActiveRecord::Base
  belongs_to :user

  validates :price,       :presence => true
  validates :description, :presence => true
  validates :link,        :presence => true
  validates :kind,        :presence => true

  attr_accessible :description, :kind, :link, :price, :title

  KINDS = ["Bebidas", "Beleza e Saúde", "Celulares e Telefones", "DVDs e CDs", "Eletrodomésticos", "Eletrônicos", "Esportes e Lazer", "Informática", "Livros", "Roupas e Calçados", "Viagens"]

  default_scope order("created_at desc")
  scope :today, where("created_at >= ?", Date.today)
end
