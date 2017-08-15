class PaymentsController < ApplicationController
  before_action :authorize, except: :index

  def index
    @payments = Payment.all.order(id: :desc)
  end

  def new_match_payment
    @payment = Payment.new
  end

  def create_match_payment
    payment = Payment.new payment_params
    if payment.save(context: :create_match_payment)
      flash[:info] = "Você efetuou um pagamento com sucesso"
    else
      flash[:info] = "Erro: todos os campos precisam ser preenchidos."
    end

    redirect_to root_path
  end

  def new_month_payment
    @payment = Payment.new
  end

  def create_month_payment
    payments_params = params[:payments]
    player = Player.find(payments_params[:player_id])
    month_number = payments_params[:month_number]
    year = payments_params[:year]
    value = payments_params[:value]

    if Payment::pay_month(month_number, year, value, player)
      flash[:info] = "Pagamento mensal efetuado com sucesso"
      redirect_to payments_path
    else
      flash[:info] = "Ocorreu um erro"
      redirect_to payments_path
    end
  end

  def new_credit
    @payment = Payment.new
  end

  def create_credit
    payment = Payment.new payment_params
    if payment.save(context: :create_credit)
      flash[:info] = "Crédito adicionado"
      redirect_to payments_path
    else
      flash[:info] = "Ocorreu um erro"
      redirect_to payments_path
    end
  end

  def new_debit
    @payment = Payment.new
  end

  def create_debit
    negative_value = (params[:payment][:value].to_f * -1)
    description = params[:payment][:description]
    payment = Payment.new value: negative_value, description: description
    if payment.save(context: :create_credit)
      flash[:info] = "Crédito adicionado"
      redirect_to payments_path
    else
      flash[:info] = "Ocorreu um erro"
      redirect_to payments_path
    end
  end

  private

  def payment_params
    params.require(:payment).permit(:match_id, :player_id, :value, :description)
  end
end