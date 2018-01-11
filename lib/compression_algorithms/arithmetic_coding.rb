
class Debug
  def self.puts string
    Kernel.puts string
  end
end


module CompressionAlgorithms
  class ArithmeticCoding
    class Encoder
      attr_accessor :code_distribution, :code_dictionary, :BIT_PRECISION, :RANGE_MAX, :WHOLE, :HALF, :QUARTER, :THREE_QUARTER
      def initialize(bit_precision = 31)
        # These are set here just for development
        # They will be set based on the data being compressed
        @code_distribution = [] 
        @code_dictionary = []

        @BIT_PRECISION = bit_precision.freeze
        @RANGE_MAX = (2**@BIT_PRECISION).freeze
        @WHOLE = (2**@BIT_PRECISION).freeze
        @HALF = (@WHOLE / 2).freeze
        @QUARTER = (@WHOLE / 4).freeze
        @THREE_QUARTER = (@WHOLE - @QUARTER).freeze
        Debug.puts "BIT_PRECISION: #{@BIT_PRECISION}\n" +
          "RANGE_MAX: #{@RANGE_MAX}\n" +
          "WHOLE: #{@WHOLE}\n" +
          "HALF: #{@HALF}\n" +
          "QUARTER: #{@QUARTER}\n" +
          "THREE_QUARTER: #{@THREE_QUARTER}\n\n"
      end

      def encode(bytes)
      end

      def code_range(code_number)
        low_total = ([0] + @code_distribution)[0..(code_number)].inject(:+) * @RANGE_MAX / code_total;
        high_total = @code_distribution[0..code_number].inject(:+) * @RANGE_MAX / code_total;

        return (low_total...high_total);
      end

      def code_total 
        @code_distribution.inject(:+);
      end

      def add_code(new_code = nil)
        @code_distribution << 1
        @code_dictionary = new_code

        return @code_dictionary.length
      end

      def get_code(code_number)
        @code_dictionary[code_number]
      end
    end
  end
end
