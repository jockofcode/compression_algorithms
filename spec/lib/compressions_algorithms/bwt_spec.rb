require 'spec_helper'
require 'compression_algorithms/bwt.rb'

RSpec.describe ::CompressionAlgorithms::BWT do

  context "when processing the text banana" do

    let(:banana_transformed) { ["nnbaaa",3] }
    let(:banana_array) { described_class.create_shifts("banana") }
    it "will reconstruct without an index" do
      expect(described_class.reconstruct(described_class.transform("banana"," ")," ")).to eq("banana")
    end

    it "will return the index 3" do
      expect(described_class.get_index_from_sorted(banana_array)).to be(3)
    end

    it "will give me the last column matching" do
      expect(described_class.get_last_column_from_sorted(banana_array)).to eq("nnbaaa")
    end

    it "will return banana when the transformed version is reconstructed" do
      expect(described_class.reconstruct(*banana_transformed)).to eq("banana")
    end
  end

  context "#{described_class.class.to_s}::create_shifts" do
    it "will return an array of one character when passed to it" do
      expect(described_class.create_shifts("a")).to eq(["a"])
    end
    it "will return an array of two strings when two chars are passed to it" do
      expect(described_class.create_shifts("ab")).to eq(["ab","ba"])
    end
    it "will return an array of three strings when three chars are passed to it" do
      expect(described_class.create_shifts("abc")).to eq(["abc","bca","cab"])
    end
  end

  context "get_last_column_from_sorted" do
    it "will return the last column" do
      expect(described_class.get_last_column_from_sorted(["ab","ba"])).to eq("ba")
    end
    it "will return the last column" do
      expect(described_class.get_last_column_from_sorted(["abc","bca","cab"])).to eq("cab")
    end
  end

  context "get_index_from_sorted" do
    it "will return the index in the sorted array" do
      expect(described_class.get_index_from_sorted(["cab","abc","bca"])).to eq(2)
    end
  end
end
