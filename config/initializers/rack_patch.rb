# See https://github.com/rack/rack/issues/322

module OmniAuth
  class Builder
    def rack14?
      true
    end
  end
end
