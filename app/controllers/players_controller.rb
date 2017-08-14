class PlayersController < ApplicationController
  before_action :authorize

  def index
    @players = Player.all
  end

  def new
    @player = Player.new
  end

  def create
    player = Player.new player_params
    if player.save
      flash[:info] = "Você criou jogadores com sucesso"
    else
      flash[:info] = "Erro: Nome precisa existir e ser diferente de qualquer outro."
    end

    redirect_to players_path
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])

    if @player.update player_params
      flash[:info] = "Você editou com sucesso"
    end

    redirect_to players_path
  end

  def destroy
    if Player.find(params[:id]).delete
      flash[:info] = "Você deletado com sucesso"
    end

    redirect_to players_path
  end

  private

  def player_params
    params.require(:player).permit(:name)
  end
end