# -*- encoding : utf-8 -*-
class FrontendController < ApplicationController
  before_filter :authorise
  before_filter :get_tag, only: [:index, :rating]

  def index
    @images = get_images((params[:order] || 'time'), (params[:page] || 1))
  end

  def view
    @images = @user.own_images if @user
  end

  def like
    @image = Image.find_by_id(params[:photo_id])
    if @user.images << @image
      @image.likes_count += 1
      @image.save
    end unless @user.images.exists? @image
    respond_to do |format|
      format.html {redirect_to action: :index}
      format.js
    end
  end

  def post
    @post = Image.find_by_id(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def rules
  end

  def about
  end

  def gifts
  end

  def lipton
  end

  def login
    session[:id] = nil
    redirect_to '/'
  end

  def callback
    user = Auth.where(provider: env['omniauth.auth'].provider, uid: env['omniauth.auth'].uid)
    if user.nil?
      user = Auth.new(
          provider: env['omniauth.auth'].provider,
          uid: env['omniauth.auth'].uid,
          name: env['omniauth.auth'].info.name,
          data: env['omniauth.auth'].info.to_s,
          accepted_deal: true
      )
      user.email = env['omniauth.auth'].info.email unless env['omniauth.auth'].info.email.blank?
      user.save
      user = Auth.find_by_uid(user.uid)
    end
    session[:id] = user.id
    redirect_to action: :index
  end

  def final_stage
    if params[:post]
       @user.email = params[:post][:email]
       @user.is_subscribed = params[:post][:is_subscribed]
       @user.accepted_deal = params[:post][:accepted_deal]
       @success = true if @user.save!
    end
    respond_to do |format|
      format.html {redirect_to action: index}
      format.js
    end
  end

  def blank
    redirect_to action: :index unless @tag.nil?
    render nothing: true
  end

  def failure
  end

  protected
  def authorise
     @user = Auth.find(session[:id]) if session[:id]
  end

  def get_tag
    @tag = Hashtag.active
    redirect_to action: 'blank' if @tag.nil?
  end

  def get_images(order,page = 1)
    order_by = case order
      when 'time'
        'created_at DESC, id DESC'
      when 'rate'
        'likes_count DESC, id DESC'
      end
    @tag.images.order(order_by).page(page).per 24
  end
end
