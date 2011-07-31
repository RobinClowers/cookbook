require 'ostruct'
require './cookbook'

module Program
  def self.run
    program = self
    book = load_or_create
    current = view
    Shoes.app(
      :width => 800,
      :height => 600) do
      stack do
        current.recipe = book.recipes.first
        current.title = title current.recipe.title
        current.description = para current.recipe.description
        list_box(:items => book.recipes, :choose => current.recipe) do |list|
          program.select_recipe list.text
        end
        flow do
          button "Next Recipe" do
            puts 'accessing recipe'
            index = book.recipes.index(current.recipe) + 1
            program.select_recipe book.recipes.at(index)
          end
          @new_recipe_button = button "New Recipe" do
            @new_recipe.show
          end
        end
        @new_recipe = stack do
          @title = edit_line :width => 600
          @description = edit_box :width => 600, :height => 300
          @save = button "Save"
        end
        @new_recipe.hide
        @new_recipe_button.click do
          @new_recipe.show
        end
        @save.click do
          puts 'saving'
          book.add_recipe Recipe.new({
            :title => @title.text,
            :description => @description.text })
            @new_recipe.hide
            current.title.text = @title.text
            current.description.text = @description.text
            book.save
            puts 'recipe added'
        end
     end
   end

  end

  def self.select_recipe(recipe)
    view.title.text = recipe.title
    view.description.text = recipe.description
  end

  def self.view
    @current ||= OpenStruct.new
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
