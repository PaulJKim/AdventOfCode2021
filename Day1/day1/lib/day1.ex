defmodule Day1 do
  @moduledoc """
  Documentation for `Day1`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day1.hello()
      :world

  """

  def countIncreases do
    list = File.read!("lib/AdventOfCodeDay1.txt") |> String.split("\n")
    list |> Enum.with_index |> Enum.count(fn({value, index}) -> index + 1 < Enum.count(list) and Integer.parse(value) < Integer.parse(Enum.at(list, index + 1))
    end)
  end

  @spec countIncreasesByWindow :: non_neg_integer
  def countIncreasesByWindow do
    list = File.read!("lib/AdventOfCodeDay1.txt") |> String.split("\n")
    list 
    |> Enum.with_index(1)
    |> Enum.count(
      fn({value, index}) ->
        index + 2 < Enum.count(list) and
        (Enum.at(list, index - 1) |> String.to_integer) + 
        (value |> String.to_integer) + 
        (Enum.at(list, index + 1) |> String.to_integer) < 
        (value |> String.to_integer) + 
        (Enum.at(list, index + 1) |> String.to_integer) + 
        (Enum.at(list, index + 2) |> String.to_integer)
    end)
  end
end
