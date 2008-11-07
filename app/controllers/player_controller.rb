class PlayerController < ApplicationController
  before_filter :login_required
  def index
    @prizes = Prize.find_all_by_sponsor_id(current_user.id)
  end
end
