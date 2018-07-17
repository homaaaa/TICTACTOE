class Player
  attr_accessor :firstname, :type

  def initialize(firstname, type)
    @firstname = firstname
    @type = type
    puts "#{@firstname}, tu joueras avec les #{@type}"
  end
end
