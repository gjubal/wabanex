defmodule WabanexWeb.SchemaTest do
  use WabanexWeb.ConnCase, async: true

  alias Wabanex.User
  alias Wabanex.Users.Create

  describe "users query" do
    test "returns user when valid id is provided", %{conn: conn} do
      params = %{email: "gabriel@gmail.com", name: "Gabriel", password: "123456"}

      {:ok, %User{id: user_id}} = Create.call(params)

      query = """
        {
          getUser(id: "#{user_id}"){
            name
            email
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: query})
        |> json_response(:ok)

      expected_response = %{
        "data" => %{
          "getUser" => %{
            "email" => "gabriel@gmail.com",
            "name" => "Gabriel"
          }
        }
      }

      assert response == expected_response
    end
  end

  describe "users mutation" do
    test "creates user when all parameters are valid", %{conn: conn} do
      mutation = """
        mutation {
          createUser(input: {
            name: "Gabriel 2", email: "gabriel2@gmail.com", password: "1234567"
          }){
            id
            name
          }
        }
      """

      response =
        conn
        |> post("/api/graphql", %{query: mutation})
        |> json_response(:ok)

      assert %{"data" => %{"createUser" => %{"id" => _id, "name" => "Gabriel 2"}}} = response
    end
  end
end
