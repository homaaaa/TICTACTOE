require 'colorize'
require 'pry'
require_relative 'BoardCase'
#require_relative 'Board'
#require_relative 'Player'
#==================================== Board ===============================================#
#==========================================================================================#



class Board
  # TO DO : la classe a 1 attr_accessor, une array qui contient les BoardCases
  attr_accessor :boardcases
  def initialize
    # TO DO :
    # Quand la classe s'initialize, elle doit créer 9 instances BoardCases
    # Ces instances sont rangées dans une array qui est l'attr_accessor de la classe

    @boardcases = []
    for i in (1..9)
      @boardcases << BoardCase.new(i.to_s)
    end
    
    print_board
  end

  def print_board
    # TO DO : afficher le plateau

    barre = '|'.green
    x = ' ' * 3
    y = ' ' * 14 + barre + ' ' * 7 + barre
    z = ' ' * 6 + '_'.green * 26

    puts
    puts
    puts y
    puts ' ' * 10 + @boardcases[0].value + x + barre + x + @boardcases[1].value + x + barre + x + @boardcases[2].value
    puts y
    puts z
    puts
    puts y
    puts ' ' * 10 + @boardcases[3].value + x + barre + x + @boardcases[4].value + x + barre + x + @boardcases[5].value
    puts y
    puts z
    puts
    puts y
    puts ' ' * 10 + @boardcases[6].value + x + barre + x + @boardcases[7].value + x + barre + x + @boardcases[8].value
    puts y
    puts
    puts
  end

  def play(choice, result)
    # TO DO : une méthode qui change la BoardCase jouée en fonction de la valeur du joueur (X, ou O)
    @boardcases[choice - 1].value = result
  end

  def already_played?(choice)
    if @boardcases[choice - 1].value == 'X'.blue.bold || @boardcases[choice - 1].value == 'O'.red.bold
      true
    else
      false
    end
  end

  def victory?
    # TO DO : qui gagne ?
    win_combos = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
    victory = 0
    win_combos.each do |combo|
      if @boardcases[combo[0]].value == 'X'.blue.bold && @boardcases[combo[1]].value == 'X'.blue.bold && @boardcases[combo[2]].value == 'X'.blue.bold
        victory = 1
      elsif @boardcases[combo[0]].value == 'O'.red.bold && @boardcases[combo[1]].value == 'O'.red.bold && @boardcases[combo[2]].value == 'O'.red.bold
        victory = 2
      end
    end
    victory
  end
end

#==================================== Player & Game =======================================#
#==========================================================================================#

class Player
  # TO DO : la classe a 2 attr_accessor, son nom, sa valeur (X ou O). Elle a un attr_writer : il a gagné ?
  attr_accessor :firstname, :type
  # attr_writer :state

  def initialize(firstname, type)
    # TO DO : doit régler son nom, sa valeur, son état de victoire
    @firstname = firstname
    @type = type
    puts "#{@firstname}, tu joueras avec les #{@type}"
  end
end

class Game
  attr_accessor :players, :board

  def initialize
    # TO DO : créé 2 joueurs, créé un board
    puts
    puts    '   ╦  ╔═╗╔╦╗╗╔═╗  ╔═╗╦  ╔═╗╦ ╦ '
    puts    '   ║  ║╣  ║  ╚═╗  ╠═╝║  ╠═╣╚╦╝ '
    puts    '   ╩═╝╚═╝ ╩  ╚═╝  ╩  ╩═╝╩ ╩ ╩  '
    puts    ' ╔╦╗╦╔═╗   ╔╦╗╔═╗╔═╗   ╔╦╗╔═╗╔═╗  │ │ '
    puts    '  ║ ║║      ║ ╠═╣║      ║ ║ ║║╣   │ │ '
    puts    '  ╩ ╩╚═╝    ╩ ╩ ╩╚═╝    ╩ ╚═╝╚═╝  o o '
    puts
    puts

    puts 'Quel est le nom du premier joueur ?'
    print '> '
    player1_firstname = gets.chomp
    player1 = Player.new(player1_firstname, 'X'.blue.bold)
    puts
    puts '_' * 38
    puts
    puts 'Quel est le nom du deuxième joueur ?'
    print '> '
    player2_firstname = gets.chomp
    player2 = Player.new(player2_firstname, 'O'.red.bold)

    @players = [player1, player2]

    @board = Board.new
  end

  def launch_game
    # TO DO : lance la partie

    9.times do |i|
      if @board.victory? == 0
        turn(i)
      else
        if @board.victory? == 1
    

          puts "#{@players[0].firstname} a gagné !!!"
        else
          puts "#{@players[1].firstname} a gagné !!!"
       end
        exit
       end
    end
    puts '╔╦╗╦╔═╗ │'
    puts ' ║ ║║╣  │'
    puts ' ╩ ╩╚═╝ o'
  end

  def turn(i)
    # TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
    # donne 0 ou 1 pour l'alternance des joueurs
    n = i % 2
    puts "#{@players[i % 2].firstname}, sur quelle case souhaites-tu jouer (entre 1 et 9) ?"
    choice = gets.chomp.to_i

    while !choice.between?(1, 9) || (@board.already_played?(choice) == true)
      if !choice.between?(1, 9)
        puts "Tu dois saisir un nombre entre 1 et 9 ! #{@players[n].firstname}, sur quelle case souhaites-tu vraiment jouer ?"
        choice = gets.chomp.to_i
      elsif @board.already_played?(choice) == true
        puts 'Cette case est déjà prise !'
        puts "#{@players[n].firstname}, sur quelle case souhaites-tu jouer (entre 1 et 9) ?"
        choice = gets.chomp.to_i
      end

   end

    #####
    @board.play(choice, @players[n].type)
    @board.print_board
  end
end

Game.new.launch_game