class Prawn::SVG::Elements::Ellipse < Prawn::SVG::Elements::Base
  USE_NEW_ELLIPSE_CALL = Prawn::Document.instance_methods.include?(:ellipse)

  def parse
    require_attributes 'rx', 'ry'

    @x = attributes['cx'].to_f || 0
    @y = attributes['cy'].to_f || 0
    @rx = attributes['rx'].to_f
    @ry = attributes['ry'].to_f

    require_positive_value @rx, @ry
  end

  def apply
    add_call USE_NEW_ELLIPSE_CALL ? "ellipse" : "ellipse_at", [@x, @y], @rx, @ry
  end

  def bounding_box
    [@x - @rx, @y + @ry, @x + @rx, @y - @ry]
  end
end

