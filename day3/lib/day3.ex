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
    oxygen_binary = getOxygenRating(list, 0)
    c02_binary = getC02Rating(list, 0)

    calculateLifeSupportRating(oxygen_binary, c02_binary)
  end

  defp calculateLifeSupportRating(oxygen_rating, c02_rating) do
    (oxygen_rating |> Integer.parse(2) |> elem(0)) * (c02_rating |> Integer.parse(2) |> elem(0))
  end

  @spec getOxygenRating([...], any) :: [...]
  def getOxygenRating([one_string], _) do
    IO.puts("Finished")
    one_string
  end

  def getOxygenRating(list_of_binaries, current_index) do
    # Potential Approach:
    # As you iterate through each binary string while looking at a bit
    # Sort each binary into a new list depending on if the current bit is 1 or 0
    # Determine which value was more popular/unpopular by using counts
    # Repeat the process on the selected subset of binary strings until only one string left
    {_, zero_list, one_list} = list_of_binaries |> Enum.reduce({current_index, [], []}, fn (string, {current_index, zero_list, one_list}) ->
      if (string |> String.graphemes |> Enum.at(current_index)) == "0" do
        {current_index, [string | zero_list], one_list}
      else
        {current_index, zero_list, [string | one_list]}
      end
    end)

    if Enum.count(zero_list) > Enum.count(one_list) do
      IO.puts("One list had count: #{Enum.count(one_list)}")
      IO.puts("Zero list had count: #{Enum.count(zero_list)} and was chosen with index #{current_index + 1}")
      getOxygenRating(zero_list, current_index + 1)
    else
      IO.puts("Zero list had count: #{Enum.count(zero_list)}")
      IO.puts("One list had count: #{Enum.count(one_list)} and was chosen with index #{current_index + 1}")
      getOxygenRating(one_list, current_index + 1)
    end
  end

  def getC02Rating([one_string], _) do
    IO.puts("Finished")
    one_string
  end

  def getC02Rating(list_of_binaries, current_index) do
    # Potential Approach:
    # As you iterate through each binary string while looking at a bit
    # Sort each binary into a new list depending on if the current bit is 1 or 0
    # Determine which value was more popular/unpopular by using counts
    # Repeat the process on the selected subset of binary strings until only one string left
    {_, zero_list, one_list} = list_of_binaries |> Enum.reduce({current_index, [], []}, fn (string, {current_index, zero_list, one_list}) ->
      if (string |> String.graphemes |> Enum.at(current_index)) == "0" do
        {current_index, [string | zero_list], one_list}
      else
        {current_index, zero_list, [string | one_list]}
      end
    end)

    if Enum.count(zero_list) <= Enum.count(one_list) do
      IO.puts("One list had count: #{Enum.count(one_list)}")
      IO.puts("Zero list had count: #{Enum.count(zero_list)} and was chosen with index #{current_index + 1}")
      getC02Rating(zero_list, current_index + 1)
    else
      IO.puts("Zero list had count: #{Enum.count(zero_list)}")
      IO.puts("One list had count: #{Enum.count(one_list)} and was chosen with index #{current_index + 1}")
      getC02Rating(one_list, current_index + 1)
    end
  end
end
