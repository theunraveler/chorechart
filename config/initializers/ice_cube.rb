module IceCube
  def self.use_psych?
    @use_psych ||= defined?(Psych)
  end
end
