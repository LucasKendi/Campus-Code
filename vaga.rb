class Vaga
  attr_accessor :titulo, :descricao, :candidatos
  def initialize(titulo, descricao, ativa=false)
    @titulo = titulo
    @descricao = descricao
    @ativa = ativa
    @candidatos = []
  end

  def ativar!
    self.ativa = true
  end

  def ativa?
    ativa
  end

  def include?(termo)
    titulo.downcase().include?(termo.downcase()) || descricao.downcase().include?(termo.downcase())
  end

  def formatar
    "#{titulo},#{descricao},#{ativa},#{candidatos}"
  end

  private

  attr_accessor :ativa
end