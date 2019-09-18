require_relative 'vaga'

def menu
  puts '--------------------------------'
  puts 'Boas vindas - Sistema de vagas'
  puts '#1. Inserir uma vaga'
  puts '#2. Ver vagas'
  puts '#3. Fazer uma busca'
  puts '#4. Ativar vagas'
  puts '#5. Sair'
  puts '--------------------------------'
  print 'Digite uma opção: '
  gets.to_i
end

def imprimir_vagas(vagas)
  vagas.each_with_index do |v, index|
    puts "Vaga nº#{index+1}"
    puts "Titulo: #{v.titulo}"
    puts "Descrição: #{v.descricao}"
    puts "Status: #{v.ativa? ? 'Ativo' : 'Inativo'}"
    puts ''
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
    vaga = Vaga.new(params[0], params[1], params[2] == "true")
    vagas << vaga
  end
  vagas
end

opcao = menu
vagas = ler_vagas
while(opcao != 5) do
  if opcao == 1
    print 'Digite o titulo da vaga: '
    titulo = gets.chomp

    print 'Digite a descrição da vaga: '
    descricao = gets.chomp

    vaga = Vaga.new(titulo, descricao)
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
  end
  opcao = menu
end
