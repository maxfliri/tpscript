module Enumerable
  def hmap
    self.reduce({}) do |map, item|
      key, value = yield item
      map.tap {|map| map[key] = value }
    end
  end
end
