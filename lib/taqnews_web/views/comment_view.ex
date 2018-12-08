defmodule TaqnewsWeb.CommentView do
  use TaqnewsWeb, :view
  alias TaqnewsWeb.CommentView

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, CommentView, "post.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{id: comment.id,
      post_id: comment.week_id,
      body: comment.body,
      user: comment.user}
  end
end
