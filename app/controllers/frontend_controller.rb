# -*- encoding : utf-8 -*-
class FrontendController < ApplicationController
  before_filter :authorise, except: [:login]
  before_filter :get_tag, only: [:index, :rating]

  def index
    @images = get_images((params[:order] || 'time'), (params[:page] || 1))
    @hashtags = Hashtag.order('start_time')
  end

  def view
    @images = @user.own_images if @user
    redirect_to '/' if @user.provider == 'facebook'
  end

  def like
    @image = Image.find_by_id(params[:photo_id])
    if @user.images << @image
      @image.likes_count += 1
      @image.save
    end unless @user.images.exists? @image or @image.hashtag != Hashtag.active
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
    user = Auth.find_by_provider_and_uid(env['omniauth.auth'].provider, env['omniauth.auth'].uid) || nil
    if user.nil?
      user = Auth.new(
          provider: env['omniauth.auth'].provider,
          uid: env['omniauth.auth'].uid,
          name: env['omniauth.auth'].info.name,
          data: env['omniauth.auth'].info.to_s
      )
      user.email = env['omniauth.auth'].info.email unless env['omniauth.auth'].info.email.nil?
      user.save
    end
    session[:id] = user.id
  end

  def final_stage
    if params[:post]
       @user.email = params[:post][:email]
       @user.is_subscribed = params[:post][:is_subscribed]
       @user.accepted_deal = params[:post][:accepted_deal]
       @user.save
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
    tag = @tag
    tag = Hashtag.find_by_tag(params[:tag]) if params[:tag]
    tag.images.where(is_blocked: false).order(order_by).page(page).per 24
  end
end
