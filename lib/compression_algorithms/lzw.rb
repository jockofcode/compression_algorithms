 require 'byebug'
module CompressionAlgorithms
  class LZW
    attr_reader :dictionary
    def initialize(data_unit_bit_size = 8)
      @dictionary = (0..255).map{ |number| [number,[number]] }.to_h
    end

    def compress(string)
      output = []
      input = string.unpack("C*")
      position = 0
      while position < input.length do
        largest_match =  find_largest_match_token(input, position)
        add_to_dictionary(input,position,@dictionary[largest_match].length)
        output << largest_match
        position += @dictionary[largest_match].length
      end
      output
    end

    def find_largest_match_token(input,position)
      length = 0
      result = nil
      loop do
#        byebug
        puts "Searching for: #{input[position..(position+length)]}"
        search_token = @dictionary.invert[input[position..(position+length)]]
        puts "found #{search_token}" if search_token
        if search_token && @dictionary[search_token].length == (length + 1)
          result = search_token
          length += 1
        else
          return result
        end
      end
    end

    def add_to_dictionary(input, position, length)
#      puts "Length is: " + length.to_s
      value = input[position..(position + length)]
      if value.length == length + 1
        @dictionary[@dictionary.keys.sort.last + 1] = value
      end
    end
  end
end
