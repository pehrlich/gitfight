class ApplicationController < ActionController::Base
  # todo - use decent_exposure.  see railscasts
  protect_from_forgery

  respond_to :html, :js


#  after_filter :add_location_header
#  # used for..? Automaticlly determining jquery responses?
#  def add_location_header
#    if request.xhr?
#      headers['Location'] = request.env["PATH_INFO"]
#    end
#  end

  rescue_from ActiveRecord::RecordNotFound, :with => :missing_fight

  # todo: ajaxify?
  def missing_fight
    flash[:notice] = "path info: #{request['PATH_INFO']} The Battle you seek has long been over.  Thirst for ye blood elsewhere."
    redirect_to '/'
  end

  def error_404
    if request.xhr?
      render :text => "They be pillagin' our repos!  Try a lookin' elsewhere.  (404)"
    else
      render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
    end
  end

  # wait until 3.1 before rescuing 404 pages: https://rails.lighthouseapp.com/projects/8994/tickets/4444-can-no-longer-rescue_from-actioncontrollerroutingerror
#  def routing_error
#    logger.warn "shwoing 404"
#    flash[:notice] = "This land has been ravaged by war.  Seek your heresay through other channels"
#    redirect_to '/'
#  end

end

