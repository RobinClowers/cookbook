class Recipe
  attr_accessor :title, :description

  def initialize(args)
    self.title = args[:title]
    self.description = args[:description]
  end

  def to_s
    self.title + "\n" + self.description
  end
end
