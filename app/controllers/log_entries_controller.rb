class LogEntriesController < ApplicationController
  prepend_before_action :authenticate_user!

  def index

  end

  def show

  end

  def new

  end

  def create
    @user = current_user
    @entry = @user.log_entries.new(log_entry_params)

    if @entry.save
      flash[:success] = 'Entry has been saved'
      redirect_to log_entry_path(@entry)
    else
      # TODO this needs to be changed to target error messages on page/in component
      flash[:danger] = @entry.errors.full_messages
      redirect_to new_log_entry_path
    end
  end

  def edit

  end

  def update
    @entry = LogEntry.find(params[:id])

    if @entry.update(log_entry_params)
      flash[:success] = 'The entry has been updated'
      redirect_to log_entry_path(@entry)
    else
      # TODO this needs to chagne to target error messages on the page/in component
      flash[:danger] = @entry.errors.full_messages
      redirect_to edit_log_entry_path(@entry)
    end
  end

  private

  def log_entry_params
    params.require(:log_entry).permit(:date, :volume)
  end
end
