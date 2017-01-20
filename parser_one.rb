class ParserOne
  require 'nokogiri'

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

  def get_all_properties(node)
    result = {}
    node.children.each do |prop| 
      next if prop.name == 'text' && sanitize_string(prop.content).nil?
      result[prop.name.to_sym] = sanitize_string(prop.content) 
    end
    result
  end

  def get_complex_properties(node)
    result = []
    node.children.each do |child|
      next if child.name == 'text' && sanitize_string(child.content).nil?
      if child.children.length > 0
        temp_result = { child.name.to_sym => {}}
        child.children.each do |under_child| 
          temp_result[child.name.to_sym][under_child.name.to_sym] = sanitize_string(under_child.content)
        end
        result << temp_result
      else
        result << { child.name.to_sym => sanitize_string(child.content) }
      end
    end
    result
  end

  def sanitize_string(str)
    result = str.gsub(/^.*(\n|\s{3,})/, '')
    result.empty? ? nil : result
  end
end