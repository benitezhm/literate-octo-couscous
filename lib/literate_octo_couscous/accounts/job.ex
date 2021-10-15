defmodule LiterateOctoCouscous.Accounts.UserJob do
  use Ecto.Schema
  import Ecto.Changeset

  alias LiterateOctoCouscous.Repo
  alias LiterateOctoCouscous.Accounts.User

  schema "user_jobs" do
    field :job_name, :string
    belongs_to :user, User

    timestamps()
  end

  def changeset(user_job, attrs, _opts \\ []) do
    user_job
    |> cast(attrs, [:job_name, :user_id])
  end

  def create_one(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
    |> validate_required([:job_name, :user_id])
    |> Repo.insert()
  end
end
