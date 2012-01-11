class CategoriesController < ApplicationController

  before_filter :authenticate_user!

  # GET /categories
  def index
    @categories = RocketTag::Tagging.select('*, COUNT(taggable_id) AS taggable_cnt').where("tagger_id=1 AND context='categories'").group('tag_id')

    if params[:sort] == "expenses"
      @categories = @categories.order('taggable_cnt DESC')
    end
  end

  # GET /category/1
  def show
    @category = RocketTag::Tag.find(params[:id])
    @taggings = @category.taggings.where("context='categories'")#.where("tagger_id=#{current_user.id}")

    # chceme zobrazit zoznam vsetkych Expensov patriacich akt. userovi AND majucich aktualny tag ako kategoriu
    @expenses = Expense.tagged_with([@category.name],on: "categories").where("user_id=#{current_user.id}").order("date DESC")
  end

end
