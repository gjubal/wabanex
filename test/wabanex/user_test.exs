defmodule Wabanex.UserTest do
  use Wabanex.DataCase, async: true

  alias Wabanex.User

  describe "changeset/1" do
    test "returns an user if all parameters are valid" do
      params = %{name: "Gabriel", email: "gabriel@gmail.com", password: "123456"}

      response = User.changeset(params)

      assert %Ecto.Changeset{
               valid?: true,
               changes: %{email: "gabriel@gmail.com", name: "Gabriel", password: "123456"},
               errors: []
             } = response
    end

    test "returns an invalid changeset if there are invalid parameters" do
      params = %{name: "Gabriel", email: "gabriel@gmail.com", password: "123456"}

      response = User.changeset(params)

      expected_response = %{
        name: ["should be at least 2 character(s)"],
        password: ["can't be blank"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
