require_relative 'day_1'

describe Day1 do
  let(:map) { Day1.new 'R2' }
  let(:example_1) { 'R2, L3' }
  let(:example_2) { 'R2, R2, R2' }
  let(:example_3) { 'R5, L5, R5, R3' }
  let(:example_4) { 'R8, R4, R4, R8' }
  let(:input) {" R4, R3, L3, L2, L1, R1, L1, R2, R3, L5, L5, R4, L4, R2, R4, L3, R3, L3, R3, R4, R2, L1, R2, L3, L2, L1, R3, R5, L1, L4, R2, L4, R3, R1, R2, L5, R2, L189, R5, L5, R52, R3, L1, R4, R5, R1, R4, L1, L3, R2, L2, L3, R4, R3, L2, L5, R4, R5, L2, R2, L1, L3, R3, L4, R4, R5, L1, L1, R3, L5, L2, R76, R2, R2, L1, L3, R189, L3, L4, L1, L3, R5, R4, L1, R1, L1, L1, R2, L4, R2, L5, L5, L5, R2, L4, L5, R4, R4, R5, L5, R3, L1, L3, L1, L1, L3, L4, R5, L3, R5, R3, R3, L5, L5, R3, R4, L3, R3, R1, R3, R2, R2, L1, R1, L3, L3, L3, L1, R2, L1, R4, R4, L1, L1, R3, R3, R4, R1, L5, L2, R2, R3, R2, L3, R4, L5, R1, R4, R5, R4, L4, R1, L3, R1, R3, L2, L3, R1, L2, R3, L3, L1, L3, R4, L4, L5, R3, R5, R4, R1, L2, R3, R5, L5, L4, L1, L1"}

  context 'for reals' do
    let(:real_map) { this_map = Day1.new input
                     this_map.follow_directions
                     this_map
                   }

    it 'distance from start' do
      expect(real_map.distance_from_start).to eq 288
    end

    it 'distance to first double' do
      expect(real_map.distance_to_first_double).to eq 111
    end
  end

  context 'first location seen twice' do
    it 'example 4' do
      this_map = Day1.new example_4
      this_map.follow_directions
      expect(this_map.first_double_x).to eq 4
      expect(this_map.first_double_y).to eq 0
      expect(this_map.distance_to_first_double).to eq 4
    end
  end

  context 'follow_directions' do
    it 'example 1' do
      this_map = Day1.new example_1
      this_map.follow_directions
      expect(this_map.current_x).to eq 2
      expect(this_map.current_y).to eq 3
    end

    it 'example 2' do
      this_map = Day1.new example_2
      this_map.follow_directions
      expect(this_map.current_x).to eq 0
      expect(this_map.current_y).to eq -2
    end

    it 'example 3' do
      this_map = Day1.new example_3
      this_map.follow_directions
      expect(this_map.current_x).to eq 10
      expect(this_map.current_y).to eq 2
    end
  end

  context 'advance' do
    it 'facing north' do
      map.current_facing = :north
      map.advance 2
      expect(map.current_y).to eq 2
    end

    it 'facing south' do
      map.current_facing = :south
      map.advance 2
      expect(map.current_y).to eq -2
    end

    it 'facing east' do
      map.current_facing = :east
      map.advance 2
      expect(map.current_x).to eq 2
    end

    it 'facing west' do
      map.current_facing = :west
      map.advance 2
      expect(map.current_x).to eq -2
    end
  end

  context 'change_facing' do
    context 'turning right' do
      it 'from north' do
        map.current_facing = :north
        map.change_facing :right
        expect(map.current_facing).to eq :east
      end

      it 'from east' do
        map.current_facing = :east
        map.change_facing :right
        expect(map.current_facing).to eq :south
      end

      it 'from south' do
        map.current_facing = :south
        map.change_facing :right
        expect(map.current_facing).to eq :west
      end

      it 'from west' do
        map.current_facing = :west
        map.change_facing :right
        expect(map.current_facing).to eq :north
      end
    end

    context 'turning left' do
      it 'from north' do
        map.current_facing = :north
        map.change_facing :left
        expect(map.current_facing).to eq :west
      end

      it 'from east' do
        map.current_facing = :east
        map.change_facing :left
        expect(map.current_facing).to eq :north
      end

      it 'from south' do
        map.current_facing = :south
        map.change_facing :left
        expect(map.current_facing).to eq :east
      end

      it 'from west' do
        map.current_facing = :west
        map.change_facing :left
        expect(map.current_facing).to eq :south
      end
    end
  end

  context 'distance_from_start' do
    it 'example 1' do
      map.current_x = 2
      map.current_y = 3
      expect(map.distance_from_start).to eq 5
    end

    it 'example 2' do
      map.current_x = 0
      map.current_y = -2
      expect(map.distance_from_start).to eq 2
    end

    it 'example 3' do
      map.current_x = 10
      map.current_y = 2
      expect(map.distance_from_start).to eq 12
    end
  end

  context 'parse directions' do
    it 'example 1' do
      expected = [[:right, 2], [:left, 3]]
      expect(map.parse_directions(example_1)).to eq expected
    end

    it 'example 2' do
      expected = [[:right, 2], [:right, 2], [:right, 2]]
      expect(map.parse_directions(example_2)).to eq expected
    end

    it 'example 3' do
      expected = [[:right, 5], [:left, 5], [:right, 5], [:right, 3]]
      expect(map.parse_directions(example_3)).to eq expected
    end
  end

  context 'convert_direction_to_tuple' do
    it { expect(map.convert_direction_to_tuple('R2')).to eq([:right, 2]) }
    it { expect(map.convert_direction_to_tuple('L2')).to eq([:left, 2]) }
  end
end

