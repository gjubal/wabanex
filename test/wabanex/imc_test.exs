defmodule Wabanex.IMCTest do
  use ExUnit.Case, async: true

  alias Wabanex.IMC

  describe "calculate/1" do
    test "returns file data when it exists" do
      params = %{"filename" => "students.csv"}

      response = IMC.calculate(params)

      expected_response =
        {:ok,
         %{
           "Dani" => 23.43749999999996,
           "Diego" => 23.04002019946976,
           "Gabul" => 22.857142857142858,
           "Rafael" => 24.897060231734173,
           "Rodrigo" => 26.234567901234566
         }}

      assert response == expected_response
    end

    test "returns error when file does not exist" do
      params = %{"filename" => "banana.csv"}

      response = IMC.calculate(params)

      expected_response = {:error, "Error when trying to open file"}

      assert response == expected_response
    end
  end
end
