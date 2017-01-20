module SuperParser

  def sanitize_string(str)
    result = str.gsub(/^.*(\n|\s{3,})/, '')
    result.empty? ? nil : result
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
end