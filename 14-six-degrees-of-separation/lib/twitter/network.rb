module Twitter
  class Network
    def initialize(connections = {})
      @connections = {}
      connections.each do |src, dsts|
        dsts.each { |dst| add_connection(src, dst) }
      end
    end

    def neighbours(node)
      @connections[node] || []
    end

    def add_connection(src, dst)
      @connections[src] ||= []
      @connections[src] |= [dst]
    end

    def remove_noise
      @connections.each do |src, dsts|
        noise = []
        dsts.each do |dst|
          noise << dst unless neighbours(dst).include? src
        end
        @connections[src] -= noise
      end
    end

    def shortest_path(root)
      cost = {}
      active_users.each { |n| cost[n] = Float::INFINITY }
      cost[root] = 0
      queue = active_users
      visited = []
      while queue.any?
        not_visited = cost.select { |k, v| not visited.include? k }
        n = not_visited.rassoc(not_visited.values.min).first
        break if cost[n] == Float::INFINITY
        visited << queue.delete(n)
        neighbours = neighbours(n) - visited
        neighbours.each do |dst|
          cost[dst] = [cost[dst], cost[n] + 1].min
        end
      end
      cost.delete_if { |k, v| v == Float::INFINITY }

      cost
    end

    def active_users
      @connections.keys
    end

    def connections_degrees
      remove_noise
      degrees = {}
      active_users.each do |root|
        costs = shortest_path(root)
        degrees[root] = {}
        costs.each do |dst, cost|
          next if cost == 0
          degrees[root][cost] ||= []
          degrees[root][cost] << dst
        end
      end

      degrees
    end
  end
end

