require "circuit_builder"
require "binary_tree"
require "circuit"
require "gate_factory"
require "and_gate"
require "gate"
require "or_gate"
require "not_gate"
require "xor_gate"

class PuzzleSolver
  def self.solve
    human_output = ["off", "on"]
    circuits = File.read("data/complex_circuits.txt").split(/^$/)
    circuits.each do |c|
      circuit = CircuitBuilder.new(c).circuit
      puts human_output[circuit.evaluate]
    end
  end
end

PuzzleSolver.solve

