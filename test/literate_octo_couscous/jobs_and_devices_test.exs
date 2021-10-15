defmodule LiterateOctoCouscous.JobsAndDevicesTest do
  use ExUnit.Case
  use LiterateOctoCouscous.DataCase

  alias LiterateOctoCouscous.Accounts
  alias LiterateOctoCouscous.Accounts.User
  alias LiterateOctoCouscous.Accounts.UserJob
  alias LiterateOctoCouscous.Accounts.UserDevice

  describe "user jobs and devices" do
    test "if no jobs and no devices, should return corresponding fields as 0" do
      {:ok, %User{email: email}} =
        Accounts.register_user(%{email: "user1@test.com", password: "Supersecurepassword123"})

      assert [
        %User{email: ^email, jobs_count: 0, devices_count: 0}
      ] = User.get_users_with_jobs_and_devices()
    end

    test "jobs and devices, should return correct values" do
      {:ok, %User{id: id_1, email: email_1}} =
        Accounts.register_user(%{email: "user1@test.com", password: "Supersecurepassword123"})

        {:ok, %User{id: id_2, email: email_2}} =
          Accounts.register_user(%{email: "user2@test.com", password: "Supersecurepassword123"})

      UserJob.create_one(%{job_name: "Job 1", user_id: id_1})
      UserJob.create_one(%{job_name: "Job 2", user_id: id_1})
      UserDevice.create_one(%{device_name: "Device 1", user_id: id_1})

      UserJob.create_one(%{job_name: "Job 1", user_id: id_2})
      UserDevice.create_one(%{device_name: "Device 1", user_id: id_2})

      assert [
        %User{email: ^email_1, jobs_count: 2, devices_count: 1},
        %User{email: ^email_2, jobs_count: 1, devices_count: 1}
      ] = User.get_users_with_jobs_and_devices()
    end
  end
end
