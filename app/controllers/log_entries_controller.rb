class LogEntriesController < ApplicationController
  prepend_before_action :authenticate_user!

  def index
    set_todays_volume
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
    if check_ownership(@entry, :change)
    elsif params[:log_entry][:addition]
      @volume = @entry.volume + params[:log_entry][:volume].to_i
      @entry.update(volume: @volume)
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
    params.require(:log_entry).permit(:date, :volume)
  end

  def check_ownership(resource, action)
    unless current_user.id == resource.user_id
      flash[:danger] = "You can only #{action} entries which you own"
      redirect_to log_entries_path
    end
  end

  def set_todays_volume
    if current_user.log_entries.where(date: Date.today).any?
      @today = current_user.log_entries.where(date: Date.today).first
    else
      @today = current_user.log_entries.new(volume: 0)
    end
  end
end
