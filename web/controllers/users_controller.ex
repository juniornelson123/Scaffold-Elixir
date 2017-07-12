defmodule Rumbl.UsersController do
	use Rumbl.Web, :controller
	def index(conn, _params) do
		users = Repo.all(Rumbl.User)
		render conn, "index.html", users: users
	end

	def show(conn,%{"id" => id}) do
		user = Repo.get Rumbl.User, String.to_integer id 
		render conn, "show.html", user: user
	end

	def new(conn, _params) do
		changeset = Rumbl.User.changeset(%Rumbl.User{})
		render conn, "new.html", changeset: changeset
	end

	def create(conn, %{"user" => user_params}) do
		changeset = Rumbl.User.changeset(%Rumbl.User{}, user_params)
		case Repo.insert(changeset) do
		
			{:ok, user} ->

				conn
				|> put_flash(:info, "#{user.name} cadastrado com sucesso")
				|> redirect(to: users_path(conn, :index))

			{:error, changeset} ->
				render conn, "new.html", changeset: changeset
		end	
	end

	def edit(conn, %{"id" => id}) do
		user = Repo.get Rumbl.User, String.to_integer id
		render conn, "edit.html", changeset: user
	end
end