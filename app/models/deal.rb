# coding: utf-8
class Deal < ActiveRecord::Base
  belongs_to :user

  # validates :company,     :presence => true
  validates :description, :presence => true
  # validates :end_date,    :presence => true
  # validates :discount,    :presence => true, :if => "self.real_price?"
  validates :kind,        :presence => true
  validates :link,        :presence => true, :format => /^https?:\/\/.+/
  validates :price,       :presence => true
  # validates :real_price
  # validates :title,       :presence => true

  attr_accessible :description, :kind, :link, :price, :title

  KINDS = ["Bebidas", "Beleza e Saúde", "Celulares e Telefones", "DVDs e CDs", "Eletrodomésticos", "Eletrônicos", "Esportes e Lazer", "Informática", "Livros", "Roupas e Calçados", "Viagens"]

  default_scope order("created_at desc")

  def self.kind(kind)
    where(:kind => kind)
  end

  scope :today, where("deals.created_at >= ?", Date.today)
end
