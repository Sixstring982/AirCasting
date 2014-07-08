require 'matrix'

class Regression
  def initialize(target, ref)
    @xs = target.map(&:value)
    @ys = align_timestamps(target, ref).map(&:value)
    @deg = deg
  end

  def run(deg)
    xs = GSL::Vector[@xs]
    ys = GSL::Vector[@ys]
    GSL::MultiFit.polyfit(xs, ys, deg).to_a
  end

  private

  def align_timestamps(target, ref)
    res = []
    i = 0
    target.each do |meas|
      i += 1 while i < ref.length - 1 && meas.time >= ref[i + 1].time
      res << ref[i]
    end
    res
  end
end
