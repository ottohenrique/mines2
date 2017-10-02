require File.expand_path('../lib/minesweeper', __FILE__)

require File.expand_path('../lib/basic_printer', __FILE__)
require File.expand_path('../lib/pretty_printer', __FILE__)

SAVEGAME_PATH = './game.sv'

def prompt(msg, d = '')
  print msg
  i = STDIN.gets.chomp.downcase
  i.empty? ? d : i
end

def iprompt(msg, d = '')
  prompt(msg, d).to_i
end

HELP = <<-HELP
  p: jogar
  f: colocar bandeira
  s: placar
  w: salvar jogo
  q: sair
  ?: ajuda (esse comando)
HELP

colors = prompt('Deseja jogar com cores? (Y/n) > ', 'y')
if colors == 'n'
  @printer = BasicPrinter
else
  @printer = PrettyPrinter
end

load_game = File.exists?(SAVEGAME_PATH) && prompt('Existe um jogo salvo. Deseja continuar? (Y/n) > ', 'y') == 'y'

if load_game
  game = MinesweeperGame.load_game(SAVEGAME_PATH)
else
  rows = iprompt('Linhas (5) > ', 5)
  cols = iprompt('Colunas (8) > ', 8)
  bombs = iprompt('Bombas (15) > ', 15)

  game = MinesweeperGame.new_game(rows, cols, bombs)
end

puts HELP

while game.still_playing?
  @printer.new(game.current_board).print

  c = prompt('comando (P/f/s/w/q/?) > ', 'p')

  case c
  when 'p', 'f'
    x = iprompt('x > ')
    y = iprompt('y > ')

    valid = if c == 'p'
              game.play!(x, y)
            else
              game.flag!(x, y)
            end

    puts "Jogada inválida, jogar novamente" unless valid
  when 's'
    puts "> bandeiras: #{game.score[:flags]}"
    puts "> abertas:   #{game.score[:opened_cells]}"
    puts "> fechadas:  #{game.score[:closed_cells]}"
  when 'w'
    game.save(SAVEGAME_PATH)
    puts "Jogo salvado com sucesso!"
  when 'q'
    exit(1)
  when '?'
    puts HELP
  else
    puts "#{x}: Comando inválido"
  end
end

puts "====="

if game.victory?
  puts "Parabéns! você encontrou todas as bombas!"
else
  puts "BOOOOOOM! que pena, você perdeu :("
end

puts ""
@printer.new(game.current_board).print
