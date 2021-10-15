defmodule LiterateOctoCouscous.HealthChecker do
  use GenServer
  require Logger

  @endpoint "https://apis.globalreader.eu/health"

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{})
  end

  @impl true
  def init(state) do
    :timer.send_after(:timer.seconds(30), self(), :check_health)
    {:ok, state}
  end

  @impl true
  def handle_info(:check_health, state) do
    do_check_health()
    {:noreply, state}
  end

  @impl true
  def handle_info(msg, state) do
    Logger.debug("Unexpected message received: #{inspect(msg)}")
    {:noreply, state}
  end

  defp do_check_health() do
    :timer.tc(fn -> Application.get_env(:literate_octo_couscous, :httpoison).get(@endpoint) end)
    |> process_response()
  end

  defp process_response({response_time,
         {:ok,
          %HTTPoison.Response{
            body: body,
            status_code: status_code
          }}}
       ) do
    body = Poison.decode!(body)
    response = %{status_code: status_code, body: body, response_time: response_time}
    Logger.info("Healthcheck: #{inspect(response)}")
  end

  defp process_response({_response_time, {:error, reason}}) do
    Logger.error(
      "Could not check the status of endpoint #{inspect(@endpoint)}, reason: #{inspect(reason)}"
    )
  end
end
