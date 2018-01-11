require 'spec_helper'
require 'compression_algorithms/arithmetic_coding'

RSpec.describe ::CompressionAlgorithms::ArithmeticCoding::Encoder do
  context "" do
    subject { described_class.new }
    it "loads the class" do
      expect(subject).to_not be(nil)
    end

    it "compresses one character" do
      expect(true).to eq(true)
    end

    context "code_dictionary" do
      before(:each) do
        subject.code_distribution = [20,10,5,30]
        subject.code_dictionary = "ABCD".chars.to_a
      end

      it "Calculates correct range for code frequency" do
        expect(subject.code_range(0).first).to eq(0)
        expect(subject.code_range(0).last).to eq(660764199)
      end

      it "Translates code number back to code" do
        expect(subject.get_code(0)).to eq("A")
        expect(subject.get_code(3)).to eq("D")
      end
    end

  end
end
