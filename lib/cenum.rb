module Kernel

  class Enum

    def self.constant_name(name)
      name.to_s.upcase
    end

    def self.[](name)
      const_get(constant_name(name))
    end

    def initialize(name)
      @value = self.class[name]
    end

    def <=>(other)
      case other
      when Enum
        @value <=> other.__value__
      when String, Symbol
        @value <=> self.class[other]
      else
        @value <=> other
      end
    end
    include Comparable

    protected

    def __value__
      @value
    end

  end

  def enum(*names)
    klass = Class.new(Enum)
    counter = 0
    names.each do |name|
      if name.is_a? Hash
        counter = name.values.first
        name = name.keys.first
      end
      klass.const_set(klass.constant_name(name), counter)
      klass.send(:define_method, "#{name}?", lambda { @value == klass[name] })
      klass.send(:define_method, "#{name}!", lambda { @value = klass[name] })
      counter += 1
    end
    (class << klass ; self ; end).send(:define_method, :values){ names }
    klass
  end

end
