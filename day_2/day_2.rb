class Day2 < Object
  KEYPAD = [['1', '2', '3'],
            ['4', '5', '6'],
            ['7', '8', '9']]

  attr_accessor :code, :current_key

  def initialize directions
    self.directions = directions
    self.current_key = '5'
    self.code = ''
  end
end
