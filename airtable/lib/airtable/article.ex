defmodule Airtable.Article do
  use ExAirtable.Table

  def base do
    %ExAirtable.Config.Base{
      id: System.get_env("AIRTABLE_BASE_ID"),
      api_key: System.get_env("AIRTABLE_API_KEY")
    }
  end

  def name, do: System.get_env("AIRTABLE_TABLE")

  def create_record(fields) when is_map(fields) do
    records = [%ExAirtable.Airtable.Record{fields: fields}]
    list = %ExAirtable.Airtable.List{records: records}
    create(list)
  end

  def create_record(_) do
    raise "The argument must be a map"
  end

  def update_record(%ExAirtable.Airtable.Record{} = record, %{} = fields) do
    updated_record = [%{ record | fields: fields }]
    list = %ExAirtable.Airtable.List{records: updated_record}

    update(list)
  end

  def update_record(_, _) do
    raise "The id must be string and fields must be a map"
  end
end
