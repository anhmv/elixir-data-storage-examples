defmodule Planemo do
  require Record

  @moduledoc """
  The Planemo record definition

  ## Examples:

    iex> require Planemo
    iex> planemo = Planemo.planemo()
  """

  Record.defrecord :planemo, [
    name: :nil,
    gravity: 0,
    diameter: 0,
    distance_from_sun: 0
  ]
end

defmodule Tower do
  require Record

  @moduledoc """
  The Tower record definition

  ## Examples:

    iex> require Tower
    iex> planemo = Tower.tower(location: "NYC", height: 241)
  """

  Record.defrecord :tower, Tower, [
    location: "",
    height: 20,
    planemo: :earth,
    name: ""
  ]
end
