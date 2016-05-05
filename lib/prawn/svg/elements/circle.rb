class Prawn::SVG::Elements::Circle < Prawn::SVG::Elements::Base
  USE_NEW_CIRCLE_CALL = Prawn::Document.instance_methods.include?(:circle)

  def parse
    require_attributes 'r'

    @x = attributes['cx'].to_f || 0
    @y = attributes['cy'].to_f || 0
    @r = attributes['r'].to_f

    require_positive_value @r
  end

  def apply
    if USE_NEW_CIRCLE_CALL
      add_call "circle", [@x, @y], @r
    else
      add_call "circle_at", [@x, @y], radius: @r
    end
  end

  def bounding_box
    [@x - @r, @y + @r, @x + @r, @y - @r]
  end
end
