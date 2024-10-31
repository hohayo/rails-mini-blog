class PostsController < InheritedResources::Base

  private

    def post_params
      params.require(:post).permit(:title, :body, :published_at, :author_id)
    end

end
