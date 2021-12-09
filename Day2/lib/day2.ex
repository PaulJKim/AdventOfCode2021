defmodule Day2 do
  @moduledoc """
  Documentation for `Day2`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day2.hello()
      :world

  """
  def calculatePosition do
    list = File.read!("lib/input.txt") |> String.split("\n") |> Enum.map(fn(row) -> String.split(row, " ") end)
    {forward, up, down} = Enum.reduce(list, {0, 0, 0}, fn (row, {forward, up, down}) ->
      cond do
        Enum.at(row, 0) == "forward" -> {forward + (Enum.at(row, 1) |> String.to_integer), up, down}
        Enum.at(row, 0) == "down" -> {forward, up, down + (Enum.at(row, 1) |> String.to_integer)}
        Enum.at(row, 0) == "up" -> {forward, up - (Enum.at(row, 1) |> String.to_integer), down}
        true -> {forward, up, down}
      end
    end)

    forward * (down + up)
  end

  def calculatePositionWithAim do
    list = File.read!("lib/input.txt") |> String.split("\n") |> Enum.map(fn(row) -> String.split(row, " ") end)
    {horizontal, aim, depth} = Enum.reduce(list, {0, 0, 0}, fn (row, {horizontal, aim, depth}) ->
      cond do
        Enum.at(row, 0) == "forward" ->
          horizontal_diff = ((Enum.at(row, 1)) |> String.to_integer)
          {horizontal + horizontal_diff, aim, depth + (aim * horizontal_diff)}
        Enum.at(row, 0) == "down" -> {horizontal, aim + (Enum.at(row, 1) |> String.to_integer), depth}
        Enum.at(row, 0) == "up" -> {horizontal, aim - (Enum.at(row, 1) |> String.to_integer), depth}
        true -> {horizontal, aim, depth}
      end
    end)

    {horizontal, aim, depth}
    horizontal * depth
  end
end
