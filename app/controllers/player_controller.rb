class PlayerController < ApplicationController
  before_filter :login_required
  def index    
    player = Player.find_by_id(current_user.id)
    @prizes = player.prize_items
    
  end
end
