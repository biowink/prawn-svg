class Prawn::SVG::Elements::Use < Prawn::SVG::Elements::Base
  attr_accessor :linked_element

  def parse
    require_attributes 'xlink:href'

    href = attributes['xlink:href']

    if href[0..0] != '#'
      raise SkipElementError, "use tag has an href that is not a reference to an id; this is not supported"
    end

    id = href[1..-1]
    @linked_element = @document.elements_by_id[id]

    if @linked_element.nil?
      raise SkipElementError, "no tag with ID '#{id}' was found, referenced by use tag"
    end

    # @x = attributes['x']
    # @y = attributes['y']
  end

  def apply
    if @x || @y
      add_call_and_enter "translate", distance(@x || 0, :x), -distance(@y || 0, :y)
    end

    # add_calls_from_element @definition_element
  end
end
