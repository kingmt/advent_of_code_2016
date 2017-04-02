class Day1 < Object
  attr_accessor :directions, :current_facing, :current_x, :current_y, :locations,
                :first_double_x, :first_double_y

  def initialize directions
    self.directions = directions
    self.current_facing = :north
    self.current_x = 0
    self.current_y = 0
    self.first_double_x = 0
    self.first_double_y = 0
    self.locations = []
  end

  def change_facing left_right
    self.current_facing = case current_facing
                          when :north
                            left_right == :right && :east ||
                            left_right == :left  && :west
                          when :east
                            left_right == :right && :south ||
                            left_right == :left  && :north
                          when :south
                            left_right == :right && :west ||
                            left_right == :left  && :east
                          when :west
                            left_right == :right && :north ||
                            left_right == :left  && :south
                          end
  end

  def advance distance
    case current_facing
    when :north
      self.current_y = current_y + distance
    when :east
      self.current_x = current_x + distance
    when :south
      self.current_y = current_y - distance
    when :west
      self.current_x = current_x - distance
    end
  end

  def follow_directions
    path = parse_directions(directions)
    path.each do |turn, distance|
      change_facing turn
      distance.times do
        advance 1
        new_location = [current_x, current_y]
        if locations.include?(new_location) &&
           first_double_x == 0 &&
           first_double_y == 0
          self.first_double_x = current_x
          self.first_double_y = current_y
        end
        locations << new_location
      end
    end
  end

  def distance_to_first_double
    first_double_x.abs + first_double_y.abs
  end

  def distance_from_start
    current_x.abs + current_y.abs
  end

  def parse_directions input
    list_of_directions = input.split(/,\s+/)
    list_of_directions.collect {|d| convert_direction_to_tuple d }
  end

  def convert_direction_to_tuple input
    # just in case
    input.upcase!
    if /([RL])(\d+)/ =~ input
      case $1
      when 'R'
        [:right, $2.to_i]
      when 'L'
        [:left, $2.to_i]
      else
        # panic!
      end
    end
  end
end
