require_relative '../parser_one'

RSpec.describe ParserOne do
  let(:test_data) { File.open('spec/parser_one_test_data.xml') }
  let(:parser) { ParserOne.new }

  it "parse type one doc" do
    result = parser.parse(test_data)
    expect(result[:customer][:fullName]).to eq('Государственное унитарное предприятие Республики Адыгея "Кошехабльский дорожный ремонтно-строительный участок"')
    expect(result[:placer][:inn]).to eq('0103005265')
    expect(result[:attachments].length).to eq(3)
    expect(result[:attachments][0][:document][:guid]).to eq('d119a996-f95b-4f7f-95b0-74df6dabdfd1')
  end

end