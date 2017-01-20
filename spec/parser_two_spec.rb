require_relative '../parser_two'

RSpec.describe ParserTwo do
  let(:test_data) { File.open('spec/parser_two_test_data.xml') }
  let(:parser) { ParserTwo.new }

  it "parse type one doc" do
    result = parser.parse(test_data)
    expect(result[:purchaseNumber]).to eq('9911111111314001000')
    expect(result[:purchaseResponsible].count).to eq(3)
  end

end