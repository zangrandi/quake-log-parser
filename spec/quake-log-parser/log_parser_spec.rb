require_relative '../spec_helper'

describe LogParser do
  let(:file_path) { "resources/qgames.log" }
  let(:parser) { LogParser.new(file_path) }

  before do
    parser.parse
  end

  it "should import matches" do
    expect(parser.matches.length).to eq(10)
  end

  it "should add events to matches" do
    expect(parser.matches.last.kill_report).to eq(
      {
        :total_kills=>131, 
        :players=> [
          "Isgalamido", 
          "Oootsimo", 
          "Dono da Bola", 
          "Assasinu Credi", 
          "Zeh", 
          "Mal"
        ], 
        :kills => {
          "Isgalamido"=>17, 
          "Oootsimo"=>21, 
          "Dono da Bola"=>12, 
          "Assasinu Credi"=>16, 
          "Zeh"=>19, 
          "Mal"=>6
        }
      }
    )
  end
end