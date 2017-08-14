class MatchesController < ApplicationController
  def index
    @matches = Match.all.order(date: :desc).paginate(page: params[:page], per_page: 10)
  end

  def show
    @match = Match.find(params[:id])
  end

  def new
    @match = Match.new
  end

  def create
    match = Match.new matches_params
    if match.save
      flash[:info] = "Você criou uma partida com sucesso"
    else
      flash[:info] = "Erro: Já existe uma partida com esta data."
    end

    redirect_to matches_path
  end

  def edit
    @match = Match.find(params[:id])
  end

  def update
    @match = Match.find(params[:id])

    if @match.update matches_params
      flash[:info] = "Você editou com sucesso"
    end

    redirect_to matches_path
  end

  def destroy
    if Match.find(params[:id]).delete
      flash[:info] = "Você excluíu com sucesso"
    end

    redirect_to matches_path
  end

  def new_month
  end

  def create_month
    Match.new.create_months_matches(params[:match][:month_number], params[:match][:next_year]) if params[:match][:month_number].present?

    flash[:info] = "Criado partidas com sucesso"
    redirect_to matches_path
  end

  private

  def matches_params
    params.require(:match).permit(:date)
  end
end