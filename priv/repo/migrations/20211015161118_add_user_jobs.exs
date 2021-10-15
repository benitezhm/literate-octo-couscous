defmodule LiterateOctoCouscous.Repo.Migrations.AddUserJobs do
  use Ecto.Migration

  def change do
    create table(:user_jobs) do
      add :user_id, references("users")
      add :job_name, :string

      timestamps()
    end
  end
end
