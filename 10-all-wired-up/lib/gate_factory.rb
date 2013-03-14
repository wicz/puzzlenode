class GateFactory
  
  GATES = %w(A O X N)

  class << self

    def create(type, *inputs)
      case type
      when 'A' then ANDGate.new(inputs)
      when 'O' then ORGate.new(inputs)
      when 'X' then XORGate.new(inputs)
      when 'N' then NOTGate.new(inputs)
      end
    end
  end
end