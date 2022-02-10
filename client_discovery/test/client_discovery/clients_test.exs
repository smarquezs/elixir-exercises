defmodule ClientDiscovery.ClientsTest do
  use ClientDiscovery.DataCase

  alias ClientDiscovery.Clients

  describe "clients" do
    alias ClientDiscovery.Clients.Client

    import ClientDiscovery.ClientsFixtures

    @invalid_attrs %{ecommerce_tech: nil, import_category: nil, import_ref: nil, internal_id: nil, internal_status: nil, owner: nil, retailer_import_url: nil, retailer_name: nil}

    test "list_clients/0 returns all clients" do
      client = client_fixture()
      assert Clients.list_clients() == [client]
    end

    test "get_client!/1 returns the client with given id" do
      client = client_fixture()
      assert Clients.get_client!(client.id) == client
    end

    test "create_client/1 with valid data creates a client" do
      valid_attrs = %{ecommerce_tech: "some ecommerce_tech", import_category: "some import_category", import_ref: "some import_ref", internal_id: "some internal_id", internal_status: "some internal_status", owner: "some owner", retailer_import_url: "some retailer_import_url", retailer_name: "some retailer_name"}

      assert {:ok, %Client{} = client} = Clients.create_client(valid_attrs)
      assert client.ecommerce_tech == "some ecommerce_tech"
      assert client.import_category == "some import_category"
      assert client.import_ref == "some import_ref"
      assert client.internal_id == "some internal_id"
      assert client.internal_status == "some internal_status"
      assert client.owner == "some owner"
      assert client.retailer_import_url == "some retailer_import_url"
      assert client.retailer_name == "some retailer_name"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Clients.create_client(@invalid_attrs)
    end

    test "update_client/2 with valid data updates the client" do
      client = client_fixture()
      update_attrs = %{ecommerce_tech: "some updated ecommerce_tech", import_category: "some updated import_category", import_ref: "some updated import_ref", internal_id: "some updated internal_id", internal_status: "some updated internal_status", owner: "some updated owner", retailer_import_url: "some updated retailer_import_url", retailer_name: "some updated retailer_name"}

      assert {:ok, %Client{} = client} = Clients.update_client(client, update_attrs)
      assert client.ecommerce_tech == "some updated ecommerce_tech"
      assert client.import_category == "some updated import_category"
      assert client.import_ref == "some updated import_ref"
      assert client.internal_id == "some updated internal_id"
      assert client.internal_status == "some updated internal_status"
      assert client.owner == "some updated owner"
      assert client.retailer_import_url == "some updated retailer_import_url"
      assert client.retailer_name == "some updated retailer_name"
    end

    test "update_client/2 with invalid data returns error changeset" do
      client = client_fixture()
      assert {:error, %Ecto.Changeset{}} = Clients.update_client(client, @invalid_attrs)
      assert client == Clients.get_client!(client.id)
    end

    test "delete_client/1 deletes the client" do
      client = client_fixture()
      assert {:ok, %Client{}} = Clients.delete_client(client)
      assert_raise Ecto.NoResultsError, fn -> Clients.get_client!(client.id) end
    end

    test "change_client/1 returns a client changeset" do
      client = client_fixture()
      assert %Ecto.Changeset{} = Clients.change_client(client)
    end
  end
end
