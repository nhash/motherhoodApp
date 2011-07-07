class HomeController < ApplicationController
  layout 'standard'
  def index
    #loads default view
  end

  def login
    #authenticate user
    #loads their profile
  end

  def logout
    #clears session
  end

  def register
    #link to user controller, fn new
  end

  def forgot_password
    #email a time-sensitive link that will ask for answer to their secret question
  end

end
