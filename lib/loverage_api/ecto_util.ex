defmodule EctoUtil do
  @moduledoc """
  Ecto関連の操作機能
  """
  import Ecto.Query, warn: false

@doc """
  SQL直接実行
  ## information
  EctoのSQLビルダを使用せずにSQLを直接実行する
  Ecto.Adapters.SQL.query()のWrapper関数
  戻り値を[%{row1},%{row2}...]形式で返す。

  ## Examples
      iex> EctoUtil.query(MyApp.Repo, "select * from users", params)
      [${id: => 1, name: => "userA name" },${id: => 2, name: => "userB name" }]
  """
   @spec query(Repo, string, [list]) :: [list]
  def query(repo, sql, params) do
    Ecto.Adapters.SQL.query(repo, sql, params)
    |> result_to_map_list()
  end

  def query(repo, sql) do
    Ecto.Adapters.SQL.query(repo, sql)
    |> result_to_map_list()
  end

  defp result_to_map_list(result) do
    columns = elem(result, 1).columns
    rows = elem(result, 1).rows
    list_maps = Enum.map(rows, fn row -> row_columns_to_map(row, columns) end)
  end

  defp row_columns_to_map(row, columns) do
    map_result =
      Enum.map(Enum.with_index(row, 0), fn {k, i} -> [Enum.at(columns, i), k] end)
      |> Enum.map(fn [a, b] -> {String.to_atom(a), b} end)
      |> Map.new()
  end
end
