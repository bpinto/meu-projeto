# -*- coding: utf-8 -*-
module DealsHelper

  def options_for_type(selected)
    options = ["","Bebidas", "Beleza e Saúde", "Celulares e Telefones", "DVDs e CDs", "Eletrodomésticos", "Eletrônicos", "Esportes e Lazer", "Informática", "Livros", "Roupas e Calçados", "Viagens"]
    options_for_select(options, selected)
  end

end
