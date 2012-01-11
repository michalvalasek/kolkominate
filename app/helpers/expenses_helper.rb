module ExpensesHelper

  def categories_links_for(expense)
    expense.categories.map do |ctg_name|
      ctg = RocketTag::Tag.find_by_name(ctg_name)
      link_to ctg.name, category_path(ctg.id)
    end.join(", ").html_safe
  end

end
