class Empresa
  attr_accessor :nome, :endereco, :cnpj
  def initialize(nome, endereco='', cnpj='')
    @nome = nome
    @endereco = endereco
    @cnpj = cnpj
  end
end