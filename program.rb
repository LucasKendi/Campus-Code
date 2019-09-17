puts 'Boas vindas - Sistema de vagas'
puts '#1. Inserir uma vaga'
puts '#2. Ver vagas'
puts '#3. Fazer uma busca'
puts '#4. Sair'
print 'Digite uma opção: '
opcao = gets.to_i
vagas = []
while(opcao != 4) do
  if opcao == 1
    puts 'Digite o titulo da vaga:'
    titulo = gets.chomp
    puts 'Digite a descrição da vaga:'
    descricao = gets.chomp

    puts 'Vaga criada'
    vaga = { titulo: titulo, descricao: descricao }
    vagas << vaga
  elsif opcao == 2
    vagas.each_with_index do |v, index|
      puts "Vaga nº#{index+1}"
      puts "Titulo: #{v[:titulo]}"
      puts "Descrição: #{v[:descricao]}"
      puts '-----------'
    end
  elsif opcao == 3
    print 'Digite a palavra ou termo buscado: '
    termo = gets.chomp
    matches = vagas.select {|v| v[:titulo].include? termo or v[:descricao].include? termo}
    if matches.any?
      puts "#{matches.length} vagas encontradas"
      matches.each_with_index do |v, index|
        puts "Vaga #{index+1}: Titulo: #{v[:titulo]}, descrição: #{v[:descricao]}"
      end
    else
      puts "Não foram encontradas vagas com o termo buscado"
    end
  end
  print 'Digite uma opção: '
  opcao = gets.to_i
end
