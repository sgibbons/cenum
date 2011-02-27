module Kernel
  def enum *names
    Class.new do
      counter = 0
      names.each do |name|
        if name.is_a? Hash
          counter = name.values.first
          name = name.keys.first
        end

        l = -> { @value == self.class.const_get(name.capitalize) }

        const_set name.capitalize, counter
        define_method "#{name}?", l
        define_method "#{name}!", l
        counter += 1
      end

      def initialize name
        @value = self.class.const_get name.capitalize
      end

      def == other
        @value == (other.respond_to? :__value__)? other.__value__ : other
      end

      def __value__
        @value
      end
    end
  end
end

