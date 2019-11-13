module SupagramErrors

  class UnauthorizedUser < ActiveRecord::RecordNotFound
    def message
      "Unauthorized user"
    end

    def http_status
      403
    end
  end

  class PostNotFound < ActiveRecord::RecordNotFound
    def message
      "Post not found"
    end

    def http_status
      400
    end
  end

  class PostAlreadyLiked < StandardError
    def message
      "User has already liked this post"
    end

    def http_status
      400
    end
  end

  class UnfollowSelf < StandardError
    def message
      "User cannot unfollow themselves"
    end

    def http_status
      400
    end
  end

end