class Kill
  attr_accessor :killer, :killed, :reason

  def initialize(killer, killed, reason)
    @killer = killer
    @killed = killed
    @reason = reason
  end

  # This is to avoid a 'circular' dependency between kill and player when printing to irb console 
  def inspect
    "#{killer&.name || '<world>'} killed #{killed.name} by #{reason}"
  end
end