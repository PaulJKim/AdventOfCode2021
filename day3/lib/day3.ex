defmodule Day3 do
  @moduledoc """
  Documentation for `Day3`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Day3.hello()
      :world

  """
  def calculateGamma do
    list = File.read!("lib/input.txt") |> String.split("\n")

    final_result =
      Enum.reduce(list, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0], fn (binary, result) ->
        String.graphemes(binary)
        |> Enum.with_index
        |> Enum.reduce(result, fn ({bit, index}, acc) ->
          if bit == "1" do
            List.replace_at(acc, index, (Enum.at(acc, index) + 1))
          else
            acc
          end
        end)
      end)


    gamma_bits = final_result
    |> convertToBinary(Enum.count(list))
    |> Enum.reduce("", fn (bit, result) -> result <> (bit |> Integer.to_string) end)

    epsilon_bits = gamma_bits
    |> String.graphemes
    |> Enum.map(fn bit -> if bit == "1" do "0" else "1" end end)
    |> Enum.reduce("", fn (bit, result) -> result <> bit end)

    (gamma_bits |> Integer.parse(2) |> elem(0)) * (epsilon_bits |> Integer.parse(2) |> elem(0))
  end

  defp convertToBinary(result, denom) do
    Enum.map(result, fn x -> Float.round(x/denom) |> trunc end)
  end
end
