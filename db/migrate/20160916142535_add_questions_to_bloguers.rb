class AddQuestionsToBloguers < ActiveRecord::Migration
  def change
    add_column :bloguers, :question1, :text
    add_column :bloguers, :answer1, :text
    add_column :bloguers, :question2, :text
    add_column :bloguers, :answer2, :text
    add_column :bloguers, :question3, :text
    add_column :bloguers, :answer3, :text
    add_column :bloguers, :question4, :text
    add_column :bloguers, :answer4, :text
    add_column :bloguers, :question5, :text
    add_column :bloguers, :answer5, :text
    add_column :bloguers, :introduction, :text
    add_column :bloguers, :conclusion, :text
  end
end
