class ExpensesController < ApplicationController

	before_filter :authenticate_user!

  # GET /expenses
  # GET /expenses.json
  def index
    @expenses = current_user.expenses.order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @expenses }
    end
  end

  # GET /expenses/1
  # GET /expenses/1.json
  def show
    @expense = Expense.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/new
  # GET /expenses/new.json
  def new
    @expense = Expense.new
    @assigned_categories = ""

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @expense }
    end
  end

  # GET /expenses/1/edit
  def edit
    @expense = Expense.find(params[:id])
	  @assigned_categories = @expense.categories.join(",")
  end

  # POST /expenses
  # POST /expenses.json
  def create
    @expense = Expense.new(params[:expense])
    unless @expense.date
      @expense.date = Time.now.to_s[0,10]
    end
    @expense.currency_id = Currency.find_by_name('Euro').id
    @expense.user_id = current_user.id
    @expense.categories = params[:categories].split(',')

    respond_to do |format|
      if @expense.save
        add_tagger_to_taggings(@expense)
        format.html { redirect_to @expense, notice: 'Expense was successfully created.' }
        format.json { render json: @expense, status: :created, location: @expense }
        format.js
      else
        format.html { render action: "new" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PUT /expenses/1
  # PUT /expenses/1.json
  def update
	  @expense = Expense.find(params[:id])
	  @expense.categories = params[:categories].split(',')

    respond_to do |format|
      if @expense.update_attributes(params[:expense])
        add_tagger_to_taggings(@expense)
        format.html { redirect_to @expense, notice: 'Expense was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1
  # DELETE /expenses/1.json
  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to expenses_url }
      format.json { head :ok }
    end
  end

  private

    def add_tagger_to_taggings(expense)
      RocketTag::Tagging.where("taggable_type='Expense' AND taggable_id=#{expense.id}").each do |tagging|
        tagging.update_attributes({tagger_id: current_user.id, tagger_type: "User"})
      end
    end

end
