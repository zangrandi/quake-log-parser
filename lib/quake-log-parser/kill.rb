class Kill
  attr_accessor :killer, :killed, :reason

  def initialize(killer, killed, reason)
    @killer = killer
    @killed = killed
    @reason = reason
  end
end