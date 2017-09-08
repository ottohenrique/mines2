class Cell
  attr_accessor :value

  def initialize(value, state = :closed)
    @value = value
    @state = state
  end

  def closed?
    @state == :closed
  end

  def played?
    @state == :played
  end

  def flagged?
    @state == :flagged
  end

  def play!
    return false unless closed?

    @state = :played

    true
  end

  def flag!
    return false if played?

    if closed?
      @state = :flagged
    else
      @state = :closed
    end

    true
  end
end
