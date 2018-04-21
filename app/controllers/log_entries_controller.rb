class LogEntriesController < ApplicationController
  prepend_before_action :authenticate_user!

  def index

  end

  def show
    @entry = LogEntry.find(params[:id])

    check_ownership(@entry, :view)
  end

  def new
    @entry = LogEntry.new
  end

  def create
    @user = current_user
    @entry = @user.log_entries.new(log_entry_params)

    if @entry.save
      flash[:success] = 'Entry has been saved'
      redirect_to log_entry_path(@entry)
    else
      render :new
    end
  end

  def edit
    @entry = LogEntry.find(params[:id])

    check_ownership(@entry, :edit)
  end

  def update
    @entry = LogEntry.find(params[:id])

    if check_ownership(@entry, :chagen)
    elsif @entry.update(log_entry_params)
      flash[:success] = 'The entry has been updated'
      redirect_to log_entry_path(@entry)
    else
      render :edit
    end
  end

  def destroy
    @entry = LogEntry.find(params[:id])

    if check_ownership(@entry, :delete)
    else
      @entry.destroy
      flash[:success] = 'The entry has been deleted'
      redirect_to log_entries_path
    end
  end

  private

  def log_entry_params
    params.permit(:date, :volume)
  end

  def check_ownership(resource, action)
    unless current_user.id === resource.user_id
      flash[:danger] = "You can only #{action} entries which you own"
      redirect_to log_entries_path
    end
  end
end
