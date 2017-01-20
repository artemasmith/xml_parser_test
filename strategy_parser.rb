class StrategyParser
  @current_parser

  def initialize(parser)
    @current_parser = parser.new
  end

  def parse_document(document)
    @current_parser.parse(document)
  end
end