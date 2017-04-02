require_relative 'day_2'

describe Day2 do
  let(:example_1) {" ULL
                     RRDDD
                     LURDL
                     UUUUD".gsub(/\s+/,'') }

  context 'code' do
    it 'finds 1985 as code' do
      code_breaker = Day2.new example_1
      code_breaker.code = '1985'
    end
  end

  context 'move to new location' do
    context 'starting at 5' do
      it 'U = 2'
      it 'UL = 1'
      it 'ULL = 1'
    end
  end
end
