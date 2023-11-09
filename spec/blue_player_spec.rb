require "./lib/blue_player"

describe BluePlayer do
  it "is a subclass of Player" do
    expect(described_class).to be < Player
  end
end