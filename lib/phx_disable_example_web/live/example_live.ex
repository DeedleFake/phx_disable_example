defmodule PhxDisableExampleWeb.ExampleLive do
  use PhxDisableExampleWeb, :live_view

  def render(assigns) do
    ~H"""
    <div class="flex flex-col gap-2">
      <div class="flex flex-col">Number: <%= @number %></div>
      <div class="flex flex-row justify-between items-center rounded-lg p-2 border-2">
        <div>No form and no phx-disable-with</div>
        <.button class="disabled:bg-zinc-300" phx-click="increment">Increment</.button>
      </div>
      <div class="flex flex-row justify-between items-center rounded-lg p-2 border-2">
        <div>No form but with phx-disable-with</div>
        <.button class="disabled:bg-zinc-300" phx-click="increment" phx-disable-with>
          Increment
        </.button>
      </div>
      <div class="flex flex-row justify-between items-center rounded-lg p-2 border-2">
        <div>With form but no phx-disable-with</div>
        <form phx-submit="increment">
          <.button class="disabled:bg-zinc-300" type="submit">Increment</.button>
        </form>
      </div>
    </div>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:number, 0)

    {:ok, socket}
  end

  def handle_event("increment", _params, socket) do
    socket =
      socket
      |> update(:number, &(&1 + 1))

    {:noreply, socket}
  end
end
