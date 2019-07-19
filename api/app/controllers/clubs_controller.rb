class ClubsController < ApplicationController
  before_action :set_club, only: [:show, :update, :destroy]

  def index
    if params[:favorites].present?
      render json: current_user.clubs
    else
      render json: Club.all
    end
  end

  def show
    render json: @club
  end

  def create
    club = Club.new(club_params)
    if club.save
      render json: club, status: :created
    else
      render json: { errors: club.errors}, status: :unprocessable_entity
    end
  end

  rescue_from ActiveRecord::RecordNotFound do |e|
    render json: { message: e.message }, status: :not_found
  end

  private    
  def set_club
    @club = Club.find(params[:id])
  end

  def club_params
    params.permit(:name, :address, :schedule, :district, :latitude, :longitude, image: [])
  end

end
