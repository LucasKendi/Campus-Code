class Vaga
  attr_accessor :titulo, :descricao, :candidatos, :empresa
  def initialize(titulo, descricao, empresa, ativa=false)
    @titulo = titulo
    @descricao = descricao
    @empresa = empresa
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

  def to_s
    "Titulo: #{titulo}\nDescrição: #{descricao}\nEmpresa: #{empresa.nome}\nStatus: #{ativa? ? 'Ativo' : 'Inativo'}"
  end

  def formatar
    "#{titulo},#{descricao},#{empresa.nome},#{ativa},#{candidatos}"
  end

  private

  attr_accessor :ativa
end