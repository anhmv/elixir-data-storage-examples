defmodule PlanemoMnesiaStorage do
  require Planemo

  def setup do
    :mnesia.create_schema([node()])
    :mnesia.start()
    :mnesia.wait_for_tables([PlanemoTable], 1000)

    :mnesia.create_table(
      PlanemoTable,
      [
        {:attributes, [:name, :gravity, :diameter, :distance_from_sun]},
        {:record_name, :planemo}
      ]
    )

    planemos_data = [
      {:mercury, 3.7, 4878, 57.9},
      {:venus, 8.9, 12104, 108.2},
      {:earth, 9.8, 12756, 149.6},
      {:moon, 1.6, 3475, 149.6},
      {:mars, 3.7, 6787, 227.9},
      {:ceres, 0.27, 950, 413.7},
      {:jupiter, 23.1, 142796, 778.3},
      {:saturn, 9.0, 120660, 1427.0},
      {:uranus, 8.7, 51118, 2871.0},
      {:neptune, 11.0, 30200, 4497.1},
      {:pluto, 0.6, 2300, 5913.0},
      {:haumea, 0.44, 1150, 6484.0},
      {:makemake, 0.5, 1500, 6850.0},
      {:eris, 0.8, 2400, 10210.0}
    ]

    insert_queries = fn -> make_insert_query(planemos_data) end

    :mnesia.transaction(insert_queries)

    IO.inspect(:mnesia.table_info(PlanemoTable, :all))
  end

  def make_insert_query([]), do: nil

  def make_insert_query([{name, gravity, diameter, distance} | tail]) do
    record = Planemo.planemo(
      name: name,
      gravity: gravity,
      diameter: diameter,
      distance_from_sun: distance
    )

    make_insert_query(tail)

    :mnesia.write(PlanemoTable, record, :write)
  end
end
