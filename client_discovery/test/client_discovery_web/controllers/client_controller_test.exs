defmodule ClientDiscoveryWeb.ClientControllerTest do
  use ClientDiscoveryWeb.ConnCase

  import ClientDiscovery.ClientsFixtures

  alias ClientDiscovery.Clients.Client

  @create_attrs %{
    ecommerce_tech: "some ecommerce_tech",
    import_category: "some import_category",
    import_ref: "some import_ref",
    internal_id: "some internal_id",
    internal_status: "some internal_status",
    owner: "some owner",
    retailer_import_url: "some retailer_import_url",
    retailer_name: "some retailer_name"
  }
  @update_attrs %{
    ecommerce_tech: "some updated ecommerce_tech",
    import_category: "some updated import_category",
    import_ref: "some updated import_ref",
    internal_id: "some updated internal_id",
    internal_status: "some updated internal_status",
    owner: "some updated owner",
    retailer_import_url: "some updated retailer_import_url",
    retailer_name: "some updated retailer_name"
  }
  @invalid_attrs %{ecommerce_tech: nil, import_category: nil, import_ref: nil, internal_id: nil, internal_status: nil, owner: nil, retailer_import_url: nil, retailer_name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all clients", %{conn: conn} do
      conn = get(conn, Routes.client_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create client" do
    test "renders client when data is valid", %{conn: conn} do
      conn = post(conn, Routes.client_path(conn, :create), client: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.client_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "ecommerce_tech" => "some ecommerce_tech",
               "import_category" => "some import_category",
               "import_ref" => "some import_ref",
               "internal_id" => "some internal_id",
               "internal_status" => "some internal_status",
               "owner" => "some owner",
               "retailer_import_url" => "some retailer_import_url",
               "retailer_name" => "some retailer_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.client_path(conn, :create), client: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update client" do
    setup [:create_client]

    test "renders client when data is valid", %{conn: conn, client: %Client{id: id} = client} do
      conn = put(conn, Routes.client_path(conn, :update, client), client: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.client_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "ecommerce_tech" => "some updated ecommerce_tech",
               "import_category" => "some updated import_category",
               "import_ref" => "some updated import_ref",
               "internal_id" => "some updated internal_id",
               "internal_status" => "some updated internal_status",
               "owner" => "some updated owner",
               "retailer_import_url" => "some updated retailer_import_url",
               "retailer_name" => "some updated retailer_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, client: client} do
      conn = put(conn, Routes.client_path(conn, :update, client), client: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete client" do
    setup [:create_client]

    test "deletes chosen client", %{conn: conn, client: client} do
      conn = delete(conn, Routes.client_path(conn, :delete, client))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.client_path(conn, :show, client))
      end
    end
  end

  defp create_client(_) do
    client = client_fixture()
    %{client: client}
  end
end
