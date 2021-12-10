defmodule Day3 do
  def calculatePowerConsumption do
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
    |> Enum.reduce("", fn (bit, result) -> result <> bit end)

    epsilon_bits = gamma_bits
    |> String.graphemes
    |> Enum.map(fn bit ->
      if bit == "1" do
        "0"
      else
        "1"
      end
    end)
    |> Enum.reduce("", fn (bit, result) -> result <> bit end)

    (gamma_bits |> Integer.parse(2) |> elem(0)) * (epsilon_bits |> Integer.parse(2) |> elem(0))
  end

  defp convertToBinary(result, denom) do
    Enum.map(result, fn x -> Float.round(x/denom) |> trunc |> Integer.to_string end)
  end

  def verifyLifeSupportRating do
    list = File.read!("lib/input.txt") |> String.split("\n")
    binary_length = list |> Enum.at(0)

    Enum.each(0..binary_length, fn
      i ->
    end)
    verifyLifeSupportRating(list)
  end

  def verifyLifeSupportRating([head | tail], current_bit_index, ) do
    # Potential Approach:
    # As you iterate through each binary string while looking at a bit
    # Sort each binary into a new list depending on if the current bit is 1 or 0
    # Determine which value was more popular/unpopular by using counts
    # Repeat the process on the selected subset of binary strings until only one string left
    IO.puts(head)
    verifyLifeSupportRating(tail)
  end

  def verifyLifeSupportRating(_) do
    IO.puts("Finished")
  end
end
