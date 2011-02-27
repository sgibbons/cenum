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
    if Enum === other
      @value <=> other.__value__
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

class Object
  def enum(*names)
    klass = Class.new(Enum)
    names.each_with_index do |name, index|
      klass.const_set(klass.constant_name(name), index)
      klass.send(:define_method, "#{name}?", lambda { @value == klass[name] })
      klass.send(:define_method, "#{name}!", lambda { @value =  klass[name] })
    end
    return klass
  end
end
