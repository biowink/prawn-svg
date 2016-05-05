class Prawn::SVG::Elements::Line < Prawn::SVG::Elements::Base
  def parse
    @x1 = attributes['x1'].to_f || 0
    @y1 = attributes['y1'].to_f || 0
    @x2 = attributes['x2'].to_f || 0
    @y2 = attributes['y2'].to_f || 0
  end

  def apply
    add_call 'line', @x1, @y1, @x2, @y2
  end

  def bounding_box
    [@x1, @y1, @x2, @y2]
  end
end
