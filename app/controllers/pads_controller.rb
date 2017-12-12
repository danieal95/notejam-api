class PadsController < ApplicationController
  skip_before_action :verify_authenticity_token
  protect_from_forgery prepend: true
  before_action :find_pad, :only => [:update, :show, :delete]
  before_action :pad_params, :only => [:create, :update]

  def create
    if check_unique_name_by_user_id
      render_409
    else
      @pad = Pad.new(@pad_param)
      if @pad.save
        render_data
      end
    end
  end

  def update
    if @user_id == @pad["user_id"] && @name == @pad['name']
      render_data
    elsif check_unique_name_by_user_id
      render_409
    else
      if @pad.update(@pad_param)
        render_data
      end
    end
  end

  def show
    render_data
  end

  def delete
    @pad.destroy
    render status: 200, json: {
      data: "null"
    }.to_json
  end

  def index
    @pad = Pad.all.select('id', 'user_id', 'name')
    render status: 200, json: {
      data: @pad
    }.to_json
  end

  private
  def pad_params
    @pad_param = params.require("pad").permit("user_id", "name")
    @user_id = @pad_param['user_id']
    @name = @pad_param['name']
    if (@user_id.present? == false) || (@name.present? == false)
      render  status: 400, json: {
        message: "any required attribute is not present"
      }.to_json
    end
  end

  def find_pad
    begin
      @pad = Pad.find params[:id]
    rescue ActiveRecord::RecordNotFound => e
      @pad = nil
    end
    if @pad == nil
      render  status: 404, json: {
        message: "The desired pad_id is not found"
      }.to_json
    end
  end

  def render_data
    render status: 200, json: {
      data: [
        id: @pad['id'],
        user_id: @pad['user_id'],
        name: @pad['name']
      ]
    }.to_json
  end

  def check_unique_name_by_user_id
    Pad.find_by(user_id: @user_id, name: @name)
  end

  def render_409
    render status: 409, json: {
      message: "The desired name is already in use by the user_id"
    }.to_json
  end
end
