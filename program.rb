require_relative 'estagio'
require_relative 'empresa'

def menu
  puts '--------------------------------'
  puts 'Boas vindas - Sistema de vagas'
  puts '#1. Inserir uma vaga'
  puts '#2. Ver vagas'
  puts '#3. Fazer uma busca'
  puts '#4. Ativar vagas'
  puts '#5. Criar empresa'
  puts '#6. Sair'
  puts '--------------------------------'
  print 'Digite uma opção: '
  gets.to_i
end

def imprimir_vagas(vagas)
  vagas.each_with_index do |v, index|
    puts "Vaga nº#{index+1}"
    puts v
  end
end

def salvar_vaga(vaga)
  File.open('vagas.txt', 'a+') do |f|
    f.puts vaga.formatar
  end
end

def atualizar_vagas(vagas)
  File.delete('vagas.txt')
  vagas.each do |v|
    salvar_vaga(v)
  end
end

def ler_vagas
  vagas = []
  File.readlines('vagas.txt').map do |row|
    vaga_string = row.chomp
    params = vaga_string.split(',')
    vaga = Vaga.new(params[0], params[1], params[2], params[3] == "true")
    vagas << vaga
  end
  vagas
end

empresas = []
opcao = menu
vagas = ler_vagas
while(opcao != 6) do
  if opcao == 1

    print 'Digite 1 para vaga comum e 2 para vaga de estágio: '
    tipo = gets.to_i

    print 'Digite o titulo da vaga: '
    titulo = gets.chomp
    
    print 'Digite a descrição da vaga: '
    descricao = gets.chomp

    print 'Digite o nome da empresa: '
    nome = gets.chomp

    empresa = Empresa.new(nome)

    if tipo == 1
      vaga = Vaga.new(titulo, descricao, empresa)
    elsif tipo == 2
      print 'Digite o curso: '
      curso = gets.chomp

      print 'Digite o prazo: '
      prazo = gets.to_i

      vaga = Estagio.new(titulo, descricao, empresa, curso, prazo)
    end

    vagas << vaga
    atualizar_vagas(vagas)

  elsif opcao == 2
    puts ''
    ativas = vagas.select {|v| v.ativa?}
    imprimir_vagas(ativas)
    
  elsif opcao == 3
    print 'Digite a palavra ou termo buscado: '
    termo = gets.chomp
    matches = vagas.select {|v| v.include?(termo) && v.ativa?}
    if matches.any?
      puts "#{matches.length} vagas encontradas"
      imprimir_vagas(matches)
    else
      puts 'Não foram encontradas vagas com o termo buscado'
    end

  elsif opcao == 4
    inativas = vagas.select {|v| !v.ativa?}
    imprimir_vagas(inativas)
    print 'Digite o número da vaga que deseja ativar: '
    index = gets.to_i - 1
    inativas[index].ativar!
    atualizar_vagas(vagas)

  elsif opcao == 5
    print 'Digite o nome da empresa: '
    nome = gets.chomp
    empresa = Empresa.new(nome)
    empresas << empresa
  end
  
  opcao = menu
end
