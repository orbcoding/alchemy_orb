class AlchemyOrb::Service
  def self.call(*args, &block)
    new(*args, &block).call
  end
end
