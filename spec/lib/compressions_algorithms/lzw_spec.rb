require 'spec_helper'
require 'compression_algorithms/lzw'

RSpec.describe ::CompressionAlgorithms::LZW do
  context "" do
    subject { described_class.new }
    it "loads the class" do
      expect(subject).to_not be(nil)
    end
    it "compresses one character" do
      expect(subject.compress("a")).to eq([97])
      expect(subject.dictionary[256]).to eq(nil)
    end

    it "compresses two characters" do
      expect(subject.compress("ab")).to eq([97,98])
      expect(subject.dictionary[256]).to eq([97,98])
    end

    it "compresses multiple characters" do
      expect(subject.compress("cdcdcd")).to eq([99,100,256,256])
      expect(subject.dictionary[256]).to eq([99,100])
    end
  end
end
