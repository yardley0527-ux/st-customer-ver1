class PagesController < ApplicationController
  def page_error_announced
    render layout: 'alt'
  end

  def page_forget
    render layout: 'auth'
  end

  def page_locked
    render layout: 'auth'
  end

  def page_login
    render layout: 'auth'
  end

  def page_login_alt
    render layout: 'auth'
  end

  def page_confirmation
    render layout: 'auth'
  end

  def page_register
    render layout: 'auth'
  end
end
