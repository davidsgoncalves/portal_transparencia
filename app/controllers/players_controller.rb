class PlayersController < ApplicationController
  before_action :authorize

  def index
    @players = Player.all
  end
end