module Prawn::SVG::Attributes::Transform
  :transform
  :rotate
  :scale
  :matrix

  class Transformation
    attr_accessor :type, :numbers

    def initialize type, numbers
      @type = type
      @numbers = numbers
    end
  end

  def parse_transform_attribute
    return unless transform = attributes['transform']

    parse_css_method_calls(transform).each do |name, arguments|
      case name
      when 'translate'
        x, y = arguments.collect {|argument| argument.to_f}
        transforms.push Transformation.new(:translate, [x, y])
      when 'rotate'
        r, x, y = arguments.collect {|a| a.to_f}
        case arguments.length
        when 1
          transforms.push Transformation.new(:rotate, [r])
        when 3
          transforms.push Transformation.new(:scale, [r, x, y])
        else
          warnings << "transform 'rotate' must have either one or three arguments"
        end
      when 'scale'
        x_scale = arguments[0].to_f
        y_scale = (arguments[1] || x_scale).to_f

        transforms.push Transformation.new(:scale, [x_scale, y_scale])
      when 'matrix'
        if arguments.length != 6
          warnings << "transform 'matrix' must have six arguments"
        end

        a, b, c, d, e, f = arguments.collect {|argument| argument.to_f}
        transforms.push Transformation.new(:matrix, [a, b, c, d, e, f])
      else
        warnings << "Unknown transformation '#{name}'; ignoring"
      end
    end
  end

  private

  def parse_css_method_calls(string)
    string.scan(/\s*(\w+)\(([^)]+)\)\s*/).collect do |call|
      name, argument_string = call
      arguments = argument_string.strip.split(/\s*[,\s]\s*/)
      [name, arguments]
    end
  end
end
