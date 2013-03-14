require_relative "../twitter"

module Twitter
  class NetworkAnalyzer
    def plot_connections(network)
      output = ""
      degrees = network.connections_degrees

      degrees.sort.each do |src, dsts|
        output << src
        dsts.sort.each do |dst|
          output << "\n" + dst.last.sort.join(', ')
        end
        output << "\n\n"
      end

      output.chomp.chomp
    end

    def extract_speaker(mention)
      mention.split(/:/).first
    end

    def extract_listeners(mention)
      content = mention.match(/[^:]+:(?<content>.*)/)[:content]
      content.scan(/@([a-z0-9_]+)/i).flatten
    end

    def run(args)
      network = Network.new
      mentions = File.read(args.first)
      mentions.split(/\n/).each do |mention|
        speaker = extract_speaker(mention)
        listeners = extract_listeners(mention)
        listeners.each do |listener|
          network.add_connection(speaker, listener)
        end
      end
      puts plot_connections(network)
    end
  end
end

