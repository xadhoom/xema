defmodule Xema.Validator.Number do
  @moduledoc """
  TODO
  """

  defmacro __using__(_) do
    quote do
      alias Xema.Validator.Number

      defp minimum?(%{minimum: nil}, _number), do: :ok
      defp minimum?(
        %{minimum: minimum, exclusive_minimum: exclusive_minimum},
        number
      ), do: Number.minimum?(minimum, exclusive_minimum, number)

      defp maximum?(%{maximum: nil}, _number), do: :ok
      defp maximum?(
        %{maximum: maximum, exclusive_maximum: exclusive_maximum},
        number
      ), do: Number.maximum?(maximum, exclusive_maximum, number)

      defp multiple_of?(%{multiple_of: nil}, _number), do: :ok
      defp multiple_of?(%{multiple_of: multiple_of}, number),
        do: Number.multiple_of?(multiple_of, number)
    end
  end

  def minimum?(minimum, _exclusive, number)
    when number > minimum,
    do: :ok
  def minimum?(minimum, true, number)
    when number == minimum,
    do: {:error, %{minimum: minimum, exclusive_minimum: true}}
  def minimum?(minimum, _exclusive, number)
    when number == minimum,
    do: :ok
  def minimum?(minimum, _exclusive, _number),
    do: {:error, %{minimum: minimum}}

  def maximum?(maximum, _exclusive, number)
    when number < maximum,
    do: :ok
  def maximum?(maximum, true, number)
    when number == maximum,
    do: {:error, %{maximum: maximum, exclusive_maximum: true}}
  def maximum?(maximum, _exclusive, number)
    when number == maximum,
    do: :ok
  def maximum?(maximum, _exclusive, _number),
    do: {:error, %{maximum: maximum}}

  def multiple_of?(multiple_of, number) do
    x = number / multiple_of
    if x - Float.floor(x) == 0,
      do: :ok,
      else: {:error, %{multiple_of: multiple_of}}
  end
end
