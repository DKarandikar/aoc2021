defmodule Day16 do
  def getLines() do
    File.read!("input/day16.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day16.getLines |> hd |> Base.decode16!() |> packet() |> elem(2)
  end

  def solvePartB() do
    lines = Day16.getLines |> hd |> Base.decode16!() |> packet() |> elem(1)
  end

  def packet(<<version::size(3), type::size(3), rem::bitstring>>) when type == 4 do
     literal(rem, 0, version)
  end

  def packet(<<version::size(3), type::size(3), 0::1, len::size(15), subpackets::size(len), final_remainder::bitstring>>) do
    # For type 0 we know what bits are left over at the end
    {remainder, output, version_acc} = packetType0(<<subpackets::size(len)>>, [], version, final_remainder)
    {remainder, calc(output, type), version_acc}
  end

  def packet(<<version::size(3), type::size(3), 1::1, len::size(11), remainder::bitstring>>) do
    # For type 1 we don't what bits are left over at the end, so packetType1 has to return the remainder
    {remainder, output, version_acc} = packetType1(remainder, [], len, version)
    {remainder, calc(output, type), version_acc}
  end

  def packetType0(<<>>, packet_list, version_acc, final_remainder), do: {final_remainder, packet_list, version_acc}

  def packetType0(bits, packet_list, version_acc, final_remainder) do
    {remainder, output, version} = packet(bits)
    packetType0(remainder, [output | packet_list], version_acc + version, final_remainder)
  end

  def packetType1(bits, packet_list, 0, version_acc), do: {bits, packet_list, version_acc}

  def packetType1(bits, packet_list, n, version_acc) do
    {remainder, output, version} = packet(bits)
    packetType1(remainder, [output | packet_list], n - 1, version_acc + version)
  end

  def literal(<<0::1, value::size(4), rem::bitstring>>, acc, v), do: {rem, acc * 16 + value, v}
  def literal(<<1::1, value::size(4), rem::bitstring>>, acc, v), do: literal(rem, acc * 16 + value, v)

  def calc(nums, 0), do: Enum.sum(nums)
  def calc(nums, 1), do: Enum.reduce(nums, 1, fn num, acc -> acc * num end)
  def calc(nums, 2), do: Enum.min(nums)
  def calc(nums, 3), do: Enum.max(nums)

  def calc([a, b], 5), do: if a < b, do: 1, else: 0
  def calc([a, b], 6), do: if a > b, do: 1, else: 0
  def calc([a, b], 7), do: if a == b, do: 1, else: 0

end

IO.inspect(Day16.solvePartA())
IO.inspect(Day16.solvePartB())
