require "./lib/red_player"

describe RedPlayer do
  it "is a subclass of Player" do
    expect(described_class).to be < Player
  end
end