defmodule LiterateOctoCouscous.Repo.Migrations.AddUserDevices do
  use Ecto.Migration

  def change do
    create table(:user_devices) do
      add :user_id, references("users")
      add :device_name, :string

      timestamps()
    end
  end
end
