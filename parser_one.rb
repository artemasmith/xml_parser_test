class ParserOne
  require 'nokogiri'
  require_relative 'super_parser'
  include SuperParser

  def parse(document)
    xml_document = Nokogiri::XML(document)
    parsed_document = {}
    parsed_document[:customer] = get_customer(xml_document)
    parsed_document[:placer] = get_placer(xml_document)
    parsed_document[:attachments] = get_attachments(xml_document)
    parsed_document
  end

  protected

  def get_guid(xml_document)
    xml_document.at_xpath("//ns2:guid").content
  end

  def get_customer(xml_document)
    get_all_properties(xml_document.at_xpath('//ns2:customer').css('mainInfo'))
  end

  def get_placer(xml_document)
    get_all_properties(xml_document.at_xpath('//ns2:placer').css('mainInfo'))
  end

  def get_attachments(xml_document)
    get_complex_properties(xml_document.at_xpath('//ns2:attachments'))
  end
end