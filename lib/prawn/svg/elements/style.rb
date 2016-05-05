class Prawn::SVG::Elements::Style < Prawn::SVG::Elements::Base
  def parse
    if @css_parser
      data = source.texts.map(&:value).join
      @css_parser.add_block!(data)
    end

    raise SkipElementQuietly
  end
end
