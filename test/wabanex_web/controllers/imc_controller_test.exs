defmodule WabanexWeb.IMCControllerTest do
  use WabanexWeb.ConnCase, async: true

  describe "index/2" do
    test "returns imc info when all params are valid", %{conn: conn} do
      params = %{"filename" => "students.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:ok)

      expected_response = %{
        "result" => %{
          "Dani" => 23.43749999999996,
          "Diego" => 23.04002019946976,
          "Gabul" => 22.857142857142858,
          "Rafael" => 24.897060231734173,
          "Rodrigo" => 26.234567901234566
        }
      }

      assert response == expected_response
    end

    test "returns error when params are invalid", %{conn: conn} do
      params = %{"filename" => "banana.csv"}

      response =
        conn
        |> get(Routes.imc_path(conn, :index, params))
        |> json_response(:bad_request)

      expected_response = %{"result" => "Error when trying to open file"}

      assert response == expected_response
    end
  end
end
