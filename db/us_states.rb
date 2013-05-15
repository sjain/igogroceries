class USStates

  attr_accessor :subregions

  def initialize
    self.subregions = Carmen::Country.named('United States').subregions
  end

  def to_name(code)
    self.subregions.coded(code).name
  end

end
