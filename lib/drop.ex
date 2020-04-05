defmodule Drop do
  require Planemo

  def drop(:ets) do
    PlanemoEtsStorage.setup()
    handle_drops(:ets)
  end

  def drop(:mnesia) do
    PlanemoMnesiaStorage.setup()
    handle_drops(:mnesia)
  end

  def handle_drops(storage) do
    receive do
      {from, planemo, distance} ->
        send(from, {planemo, distance, fall_velocity(storage, planemo, distance)})
        handle_drops(storage)
    end
  end

  def fall_velocity(:ets, planemo, distance) when distance >= 0 do
    p = hd(:ets.lookup(:planemos, planemo))
    :math.sqrt(2 * Planemo.planemo(p, :gravity) * distance)
  end

  def fall_velocity(:mnesia, planemo, distance) when distance >= 0 do
    {:atomic, [p | _]} = :mnesia.transaction(fn -> :mnesia.read(PlanemoTable, planemo) end)
    :math.sqrt(2 * Planemo.planemo(p, :gravity) * distance)
  end
end
