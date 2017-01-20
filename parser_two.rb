class ParserTwo
  require 'nokogiri'
  require_relative 'super_parser'
  include SuperParser

  def parse(document)
    xml_document = Nokogiri::XML(document)
    parsed_document = {}
    parsed_document[:purchaseNumber] = get_purchaseNumber(xml_document)
    parsed_document[:purchaseResponsible] = get_purchaseResponsible(xml_document)
    parsed_document
  end

  protected

  def get_purchaseNumber(xml_document)
    xml_document.at_css("purchaseNumber").content
  end


  def get_purchaseResponsible(xml_document)
    get_complex_properties(xml_document.at_css('purchaseResponsible'))
  end
end