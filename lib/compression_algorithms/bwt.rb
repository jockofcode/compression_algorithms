module CompressionAlgorithms
# Burrows-Wheeler Transform
class BWT
  def self.transform(string, terminator = nil)
    raise "Terminator Character Already Exists In String" if terminator && string =~ /#{terminator}/
    array_of_strings = self.create_shifts([string,terminator].join)
    index = get_index_from_sorted(array_of_strings)
    transformed_string = get_last_column_from_sorted(array_of_strings)

    return [transformed_string,index] if !terminator
    return transformed_string if terminator
  end

  def self.reconstruct(transformed_string,index = "\n" )
    transformed_chars = transformed_string.split(//)
    shifts_array = transformed_string.split(//)
    length = transformed_string.length
    (length - 1).times{
    shifts_array = shifts_array.sort.each_with_index.map{|string,index| transformed_chars[index] + string}
    }
    case index
    when Integer
      return shifts_array.sort[index]
    when String
      result = shifts_array.sort.find{ |string| string =~ /#{index}$/}
      raise "Terminator Character Not Found" if result == nil
      return result[0..-2]
    end
  end

  def self.create_shifts(string)
    length = string.length
    string_array = [string]
    (length - 1).times {
      string_array << (string_array.last[1..-1] + string_array.last[0])
    }
    string_array
  end

  def self.get_last_column_from_sorted(string_array)
    string_array.sort.map{|string| string[-1] }.join
  end
  
  def self.get_index_from_sorted(string_array)
    string_array.sort.index(string_array.first)
  end
end
end
