class CategoriesController < ApplicationController

  before_filter :authenticate_user!

  # GET /categories
  def index
    @categories = RocketTag::Tagging.select('*, COUNT(taggable_id) AS taggable_cnt').where("tagger_id=#{current_user.id} AND context='categories'").group('tag_id')

    if params[:sort] == "expenses"
      @categories = @categories.order('taggable_cnt DESC')
    end

    respond_to do |format|
      format.html
      format.json do
        ctgs = ActiveRecord::Base.connection.execute("SELECT DISTINCT t.id, t.name FROM tags t RIGHT JOIN taggings ts ON ts.tag_id=t.id WHERE ts.tagger_id=#{current_user.id} AND t.name LIKE '#{params['q']}%' ORDER BY name")
        render json: ctgs.map {|i| {id: i[1], name: i[1]} }
      end
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
