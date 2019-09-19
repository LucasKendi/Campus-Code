require_relative 'vaga'
class Estagio < Vaga
  attr_accessor :curso, :prazo
  def initialize(titulo, descricao, curso, prazo)
    super(titulo, descricao)
    @curso = curso
    @prazo = prazo
  end

  def to_s
    "Estagio \n#{super}\nCurso: #{curso}\nPrazo: #{prazo}\n"
  end
end