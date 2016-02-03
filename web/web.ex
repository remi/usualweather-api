defmodule UsualWeather.Web do
  def model do
    quote do
      use Ecto.Schema

      import Ecto
      import Ecto.Changeset
      import Ecto.Query, only: [from: 1, from: 2]
    end
  end

  def controller do
    quote do
      use Phoenix.Controller

      alias UsualWeather.Repo
      import Ecto
      import Ecto.Query, only: [from: 1, from: 2]

      import UsualWeather.Router.Helpers
    end
  end

  def view do
    quote do
      use Phoenix.View, root: "web/templates"
    end
  end

  def router do
    quote do
      use Phoenix.Router
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end