class Admin::CategoriesController < AdminController
  before_action :find_category, only: %i(edit update destroy)

  def index
    @admin_categories = Category.paginate page: params[:page]
  end

  def new
    @admin_category = Category.new
  end

  def edit; end

  def create
    @admin_category = Category.new admin_category_params

    return render :new unless admin_category.save
    redirect_to admin_categories_path, notice: t(".created")
  end

  def update
    return render :edit unless admin_category.update admin_category_params
    redirect_to admin_categories_path, notice: t(".updated")
  end

  def destroy
    if admin_category.destroy
      redirect_to admin_categories_path, notice: t(".destroyed")
    else
      redirect_to admin_categories_path, alert: t(".faild_to_destroyed")
    end
  end

  private

  attr_reader :admin_category

  def find_category
    @admin_category = Category.find_by id: params[:id]
    unless admin_category
      redirect_to admin_categories_path, alert: t("admin.categories.not_found")
    end
  end

  def admin_category_params
    params.require(:admin_category).permit :name
  end
end
