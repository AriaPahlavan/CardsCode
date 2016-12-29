defmodule Cards do
  @moduledoc """
    Provides functions for creating and handling a deck of cards
  """


  @doc """
    Creates a deck of cards.
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five",
              "Six", "Seven", "Eight", "Nine", "Ten",
              "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # Solution No. 2
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

    # Solution No. 1
    # cards = for value <- values do
    #   for suit <- suits do
    #     "#{value} of #{suit}"
    #   end
    # end
    #
    # List.flatten(cards)
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end


  def contains?(deck, card) do
    Enum.member?(deck, card)
  end


  @doc """
    Devides `deck` into a hand and the remainder of the deck.
    the `hand_size` argument indicated how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_hand
      iex> {hand, remainder} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end


  @doc """
    Saves the `deck` in `filename`.
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads the deck from `filename`.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      # underscore at the beginning of the var
      # specifies that it will not be used...
      {:error, _error_msg} -> "File does not exist!"
    end
  end


  @doc """
    Creates a deck of card, shuffles them, and devides
    the deck into a hand and the remainder of the deck.
    The `hand_size` argument indicated how many cards
    should be in the hand.

  ## Examples

      iex> {hand, remainder} = Cards.create_hand(1)
      iex> hand
      ["Jack of Clubs"]
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
