class Api::V1::ChallengesController < ApplicationController
  before_action :authenticate_user!, only: %i[create update destroy]
  before_action :set_id, only: %i[ show update destroy ]
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # GET /api/v1/challenges
  def index
    @challenges = Challenge.all
    render json: @challenges
  end

  # POST /api/v1/challenges
  def create
    @challenge = current_user.challenges.build(challenge_params)

    if @challenge.save
      render json: { message: "Success", data: @challenge }
    else
      # render json: @challenge.errors, status: :unprocessable_entity
      render json: { message: "Unsuccessful", data: @challenge.errors }
    end
  end

  # GET /api/v1/challenges/:id
  def show
    render json: @challenge
  end

  # PATCH/PUT /api/v1/challenges/:id
  def update
    if @challenge.update(challenge_params)
      render json: @challenge
    else
      render json: @challenge.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/challenges/:id
  def destroy
    @challenge.destroy
    if @challenge.destroy
      render json: { message: "Deleted Succesfully", data: @challenge }
    else
      render json: { message: "Deleted unuccesfully", data: @challenge }
    end
  end

  private

  def challenge_params
    params.require(:challenge).permit(:title, :description, :start_date, :end_date)
  end

  def set_id
    @challenge = Challenge.find(params[:id])
  end

  def record_not_found
    render json: { error: "Challenge not found. It may deleted" }
  end
end
