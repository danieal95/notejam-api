class NotesController < ApplicationController
  skip_before_action :verify_authenticity_token
  protect_from_forgery prepend: true
  before_action :find_note, :only => [:update, :show, :delete]
  before_action :note_params, :only => [:create, :update]

  def create
    if check_unique_name_by_user_id
      render_409
    else
      @note = Note.new(@note_param)
      if @note.save
        render_data
      end
    end
  end

  def update
    if @pad_id == @note["pad_id"] && @user_id == @note["user_id"] && @name == @note['name'] && @text == @note['text']
      render_data
    elsif check_unique_name_by_user_id
      render_409
    else
      if @note.update(@note_param)
        render_data
      end
    end
  end

  def show
    render_data
  end

  def delete
    @note.destroy
    render status: 200, json: {
      data: "null"
    }.to_json
  end

  def index
    @note = Note.all.select('id', 'pad_id', 'user_id', 'name', 'text')
    render status: 200, json: {
      data: @note
    }.to_json
  end

  private
  def note_params
    @note_param = params.permit("pad_id", "user_id", "name", "text")
    @pad_id = @note_param['pad_id']
    @user_id = @note_param['user_id']
    @name = @note_param['name']
    @text = @note_param['text']
    if (@pad_id.present? == false) || (@user_id.present? == false) || (@name.present? == false) || (@text.present? == false)
      render  status: 400, json: {
        message: "any required attribute is not present"
      }.to_json
    end
  end

  def find_note
    begin
      @note = Note.find params[:id]
    rescue ActiveRecord::RecordNotFound => e
      @note = nil
    end
    if @note == nil
      render  status: 404, json: {
        message: "The desired note_id is not found"
      }.to_json
    end
  end

  def render_data
    render status: 200, json: {
      data: [
        id: @note['id'],
        pad_id: @note['pad_id'],
        user_id: @note['user_id'],
        name: @note['name'],
        text: @note['text']
      ]
    }.to_json
  end

  def check_unique_name_by_user_id
    Note.find_by(user_id: @user_id, name: @name)
  end

  def render_409
    render status: 409, json: {
      message: "The desired name is already in use by the user_id"
    }.to_json
  end
end
