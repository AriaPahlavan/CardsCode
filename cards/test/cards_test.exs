defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "deck size must be 52" do
    deck_length = length(Cards.create_deck())
    assert deck_length == 52
  end

  test "shuffling randomizes a deck" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end
end
