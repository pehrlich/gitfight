class FightsController < ApplicationController

  def index
    @fight = Fight.new
    if request.xhr?
      respond_with_fight @fight # the default ajax
    else
      render 'application/index' # the default markup
    end
  end

  def create
    # this is update or create

    # only create contestants and fights if not already exisiting.
    # -- is there any reason to keep ld fights?  Possibly a curiousity at best.
    # perhaps analytical data deserves a dedicated look
    defender = Contestant.find_or_create_by_url(params[:fight][:defender])
    challenger = Contestant.find_or_create_by_url(params[:fight][:challenger])
    @fight = Fight.find_or_create_by_defender_id_and_challenger_id({:defender_id => defender, :challenger_id => challenger})
    @fight.determine
    redirect_to @fight
  end

  def update
    create
  end

  def show
    unless request.xhr?
      redirect_to "/#!/fights/#{params[:id]}"
      return
    end
    @fight = Fight.find(params[:id], :include => [:defender, :challenger])
    # todo: 404 if nil
    @fight.determine

    respond_with_fight @fight
  end

  def recent
    # why is extension needed? It doesn't fall back to html?
    render :partial => 'recent.html.haml'
  end

  protected

  def respond_with_fight(fight)
    @fight = fight
    respond_with do |format|
      format.js {  render :json => @fight.json_for_view }
      format.html { render :partial => 'fight' }
    end
  end
end
