defmodule LiterateOctoCouscous.Accounts.UserDevice do
  use Ecto.Schema
  import Ecto.Changeset

  alias LiterateOctoCouscous.Repo
  alias LiterateOctoCouscous.Accounts.User

  schema "user_devices" do
    field :device_name, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(user_device, attrs, _opts \\ []) do
    user_device
    |> cast(attrs, [:device_name, :user_id])
  end

  def create_one(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> validate_required([:device_name, :user_id])
    |> Repo.insert()
  end
end
