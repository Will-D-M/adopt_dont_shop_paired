class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :favorites

  def favorites
    # ||= is saying set session[:favorites] to Hash.new(0) if it is nil, false, or undefined
    # Otherwise set it to session[:favorites] meaning do nothing
    # Memoization
    @favorites ||= FavoritesList.new(session[:favorites])
  end
end
