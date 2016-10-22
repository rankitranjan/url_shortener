class Api::V1::ShortVisitsController < Api::V1::ApiController
  before_action :set_short_visit, only: [:show, :edit, :update, :destroy]

  def index
    @short_visits = ShortVisit.all
  end

  def show
  end

  def new
    @short_visit = ShortVisit.new
  end

  def edit
  end

  def create
    @short_visit = ShortVisit.new(short_visit_params)

    respond_to do |format|
      if @short_visit.save
        format.html { redirect_to @short_visit, notice: 'Short visit was successfully created.' }
        format.json { render :show, status: :created, location: @short_visit }
      else
        format.html { render :new }
        format.json { render json: @short_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @short_visit.update(short_visit_params)
        format.html { redirect_to @short_visit, notice: 'Short visit was successfully updated.' }
        format.json { render :show, status: :ok, location: @short_visit }
      else
        format.html { render :edit }
        format.json { render json: @short_visit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @short_visit.destroy
    respond_to do |format|
      format.html { redirect_to short_visits_url, notice: 'Short visit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_short_visit
      @short_visit = ShortVisit.find(params[:id])
    end

    def short_visit_params
      params.require(:short_visit).permit(:visitor_ip, :visitor_city, :visitor_state, :visitor_country_iso2, :short_url_id)
    end
end
