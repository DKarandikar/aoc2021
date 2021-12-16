defmodule Day16 do
  def getLines() do
    File.read!("input/day16.txt") |> String.split("\n")
  end

  def solvePartA() do
    lines = Day16.getLines
    lines |> hd |> Base.decode16!() |> packet() |> elem(2)
  end

  def packet(<<version::size(3), type::size(3), rem::bitstring>>) when type == 4 do
     literal(rem, 0, version)
  end

  def packet(<<version::size(3), type::size(3), 0::1, len::size(15), subpackets::size(len), final_remainder::bitstring>>) do
    # For type 0 we know what bits are left over at the end
    packetType0(<<subpackets::size(len)>>, [], version, final_remainder)
  end

  def packet(<<version::size(3), type::size(3), 1::1, len::size(11), remainder::bitstring>>) do
    # For type 1 we don't what bits are left over at the end, so packetType1 has to return the remainder
    packetType1(remainder, [], len, version)
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

  def solvePartB() do
    lines = Day16.getLines
    lines |> hd
  end

end

IO.inspect(Day16.solvePartA())
# IO.inspect(Day16.solvePartB())
