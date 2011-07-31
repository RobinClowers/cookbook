require './cookbook'

module Program
  def self.run
    book = load_or_create
    #book.add_recipe Recipe.new({
      #:title => 'Fried Eggs',
      #:description => 'Heat pan, add butter, crack eggs, stir until done' })
    #book.save
    book.recipes.each do |recipe|
      puts recipe.to_s
    end
  end

  def self.load_or_create
    if File.exists? 'cookbook.yaml'
      File.open('cookbook.yaml') { |file| YAML.load(file) }
    else
      Cookbook.new
    end
  end
end

Program.run
