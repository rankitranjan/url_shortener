class Api::V1::ShortUrlsController < Api::V1::ApiController
  before_action :set_short_url, only: [:show, :edit, :update, :destroy]
  before_action :authenticate, except: [:redirect]
  before_filter :check_authorization

  layout false
  respond_to :json

  def index
    @short_urls = current_user.short_urls.paginate(:page => params[:page], :per_page => 5)
    respond_with(@short_urls)
  end

  def create
    @short_url = current_user.short_urls.new({original_url: short_url_params[:original_url]})
    if @short_url.save
      render json: {success: true, status: 200, original_url: @short_url.original_url, user_id: @short_url.user_id, shorty: @short_url.shorty_full, created_at: @short_url.created_at, updated_at: @short_url.updated_at}
      else
       render :json => {success: false, :errors => @short_url.errors.to_a.uniq.join(", ")}, :status => 200
    end
  end

  def update
    if @short_url.update({ original_url: short_url_params[:original_url], user_id: @current_user.id})
      render json: {success: true, status: 200, original_url: @short_url.original_url, user_id: @short_url.user_id, created_at: @short_url.created_at, updated_at: @short_url.updated_at, shorty: @short_url.shorty_full, visits_count: @short_url.visits_count}
    else
     render :json => {success: false, :errors => @short_url.errors.to_a.uniq.join(", ")}, :status => 200
    end
  end

  def destroy
    @short_url.destroy
    render :json => { success: true }
  end

  def redirect
    sort_url = params[:sort_url]
    if sort_url
      model, id = CommonHelper.decode("#{sort_url}")
      if model && id
        short_obj = ShortUrl.find("#{id}")
        add_vistors(request, short_obj)
        short_obj.add_vistors_count
        redirect_to "#{short_obj.original_url}"
      else
        render :json => {success: false, :errors => "url not valid"}, :status => 404
      end
    else
      render :json => {success: false, :errors => "url not valid"}, :status => 404
    end
  end

  def add_vistors(request, short_obj)
    geocoder = Geocoder.search("#{request.ip}")
    short_obj.short_visits.create({
      visitor_ip: request.ip,
      visitor_country_iso2: geocoder.first.country_code,
      visitor_city: geocoder.first.city,
      visitor_state: geocoder.first.state
    })
  end

  private

    def set_short_url
      @short_url = ShortUrl.find(params[:id])
    end

    def short_url_params
      params.require(:short_url).permit(:original_url, :shorty, :visits_count, :user_id)
    end
end
