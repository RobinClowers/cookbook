require 'shoes'
require 'yaml'
require './recipe'

class Cookbook
  attr_accessor :recipes

  def initialize
    self.recipes = []
  end

  def add_recipe(recipe)
    self.recipes << recipe
  end

  def save
    file = File.new 'cookbook.yaml', 'w'
    file.puts YAML::dump self
    file.close
  end
end
