class Operator::OperatorsController < Operator::OperatorController
  before_action :set_operator, only: [:show, :edit, :update, :destroy]
  before_action :new_operator, only: [:new, :create]

  def index
    @title = t('views.operator.operators.actions.index.title')
    @operators = Operator.page(params[:page])
  end

  def show
    @title = t('views.operator.operators.actions.show.title')
  end

  def new
    @title = t('views.operator.operators.actions.new.title')
  end

  def create
    @operator.attributes = operator_params
    if @operator.save
      flash[:success] = t('activerecord.flash.operator.actions.create.success')
      redirect_to [:operator, @operator]
    else
      @title = t('views.operator.operators.actions.new.title')
      flash[:danger] = t('activerecord.flash.operator.actions.create.failure')
      render :new
    end
  end

  def edit
    @title = t('views.operator.operators.actions.edit.title')
  end

  def update
    if @operator.update_attributes(operator_params)
      flash[:success] = t('activerecord.flash.operator.actions.update.success')
      redirect_to [:operator, @operator]
    else
      @title = t('views.operator.operators.actions.edit.title')
      flash[:danger] = t('activerecord.flash.operator.actions.update.failure')
      render :edit
    end
  end

  def destroy
    if @operator.destroy
      flash[:success] = t('activerecord.flash.operator.actions.destroy.success')
    else
      flash[:danger] = t('activerecord.flash.operator.actions.destroy.failure')
    end
    redirect_to operator_operators_path
  end

  private

  def operator_params
    params.require(:operator).permit(:username, :email, :password, :password_confirmation)
  end

  def set_operator
    @operator = Operator.find(params[:id])
  end

  def new_operator
    @operator = Operator.new
  end
end
