defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a full deck of playing cards  
  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Takes an existing deck as an argument and returns a shuffled version of that deck.
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card.

  ## Examples
  
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Jack of Hearts")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand.

  ## Example

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves a permutation of a deck into the main `cards` file. Takes a deck and file name as arguments. Resulting file can be used in the `load` function(see below)

  ## Example

      iex> deck = Cards.create_deck
      iex> deck = Cards.shuffle(deck)
      iex> Cards.save(deck, "deck_of_cards")
      :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a previously saved permutation of a deck, taking the file name as an argument
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
    Takes a hand size as an argument, the function creates a deck, shuffles the deck then returns a number of cards equivilant to the `hand_size` provided. 
  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
