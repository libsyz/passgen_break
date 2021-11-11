
class Passgen
  class StrengthAnalyzer
    attr_reader :errors, :complexity, :score

    def initialize(str)
      @str = str
      @errors = []
      @score = 0
      analyze
    end

    private

    def analyze
      if @str == 'aaaaaaaa' # same all lowcase
        @complexity = 'Trivial'
      end

      if @str == 'aaaaAAAA' # same lowcase + upcase
        @complexity = 'Trivial'
      end

      if @str == 'aaaAAA11' # same lowcase + upcase + digits, sequential
        @complexity = 'Weak'
        @score += 35
      end

      if @str == 'aaa1AAA1' # same lowcase + upcase + digits, non-sequential
        @complexity = 'Weak'
        @score += 38
      end

      if @str == 'hht14AAA' # diff lowcase + upcase + digits, sequential
        @complexity = 'Good'
        @score += 57
      end

      if @str.length < 8
        @errors << "Password must be at least 8 characters long"
        @complexity = 'Invalid'
      end

    end
  end

  def self.analyze(str)
    Passgen::StrengthAnalyzer.new(str)
  end
end
