module Gem
  class FileSystem
    attr_reader :path

    def initialize(path)
      @path = Path.new(path)
    end

    def bin
      path.add 'bin'
    end

    def cache
      path.add 'cache'
    end

    def specifications
      path.add 'specifications'
    end

    def gems
      path.add 'gems'
    end

    def doc
      path.add 'doc'
    end

    def to_s
      path.to_s
    end

    alias to_str to_s

    def eql?(fs)
      case fs
      when String
        path.eql?(fs)
      when FileSystem
        path.eql?(fs.path)
      else
        false
      end
    end

    alias == eql?

    def hash
      to_s.hash
    end

    class Path
      def initialize(path)
        @path = path
      end

      def readable?
        File.readable?(@path)
      end

      def writable?
        File.writable?(@path)
      end

      def path
        @path.dup
      end

      def to_s
        @path.to_s
      end
      
      alias to_str to_s

      def add(filename)
        self.class.new(@path, filename)
      end

      def eql?(other_path)
        to_s.eql?(other_path.to_s)
      end

      alias == eql?

      def hash
        to_s.hash
      end

    end
  end
end
