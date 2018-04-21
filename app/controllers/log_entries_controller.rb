class LogEntriesController < ApplicationController
  prepend_before_action :authenticate_user!

  def index

  end

  def new

  end
end
