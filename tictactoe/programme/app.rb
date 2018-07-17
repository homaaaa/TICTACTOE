#on require les gems nécessaires et les différents fichiers du programme (1 fichier par classe)
#colorize permet de mettre un peu de couleur dans le terminal
#il faut faire un bundle install avant de lancer le programme (voir le README.md)

require 'colorize'
require 'pry'
require 'rubocop'
require_relative 'boardcase'
require_relative 'board'
require_relative 'player'
require_relative 'game'

Game.new.launch_game

#lance le programme en créant une partie et en lui appliquant la méthode launch_game su fichier game.rb