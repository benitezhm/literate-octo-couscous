defmodule LiterateOctoCouscous.HealthCheckerTest do
  use ExUnit.Case

  import Mox
  import ExUnit.CaptureLog
  require Logger

  alias LiterateOctoCouscous.HealthChecker

  setup :verify_on_exit!

  describe "HealthChecker.handle_info/2 scenarios" do
    test "handle_info/2 with :check_health message" do
      MockHTTPoison
      |> expect(:get, fn _ ->
        {:ok,
         %HTTPoison.Response{
           body:
             "{\"health\":true,\"idle_time\":950,\"last_request\":\"2021-10-15T14:15:00.800899Z\",\"node_known\":3,\"node_list\":2,\"revision\":null,\"self\":\"apis@apps1.globalreader.eu\",\"ts\":\"2021-10-15T14:30:51.149717Z\",\"uid\":\"edf0a9c3\"}",
           status_code: 200
         }}
      end)

      assert capture_log(fn ->
               HealthChecker.handle_info(:check_health, %{})
             end) =~ "Healthcheck: "
    end

    test "handle_info/2 with :check_health message and error response" do
      MockHTTPoison
      |> expect(:get, fn _ ->
        {:error, %HTTPoison.Error{id: nil, reason: :econnrefused}}
      end)

      assert capture_log(fn ->
               HealthChecker.handle_info(:check_health, %{})
             end) =~ "Could not check the status of endpoint "
    end

    test "handle_info/2 with unknown message" do
      Logger.configure(level: :debug)

      assert capture_log(fn ->
               HealthChecker.handle_info(:unknown, %{})
             end) =~ "Unexpected message received: "
    end
  end
end
