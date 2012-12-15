# -*- encoding : utf-8 -*-
class FrontendController < ApplicationController
  before_filter :authorise
  before_filter :get_tag, only: [:index, :rating]

  def index
    @images = get_images params[:order] || 'time', params[:page] || 1
  end

  def view
    @user.images.page(params[:page]).per 24
  end

  def like
    image = Image.find_by_id(params[:photo_id])
    if @user.images << image
      image.likes_count += 1
      image.save
    end unless @user.images.exists? image
    respond_to do |format|
      format.html {redirect_to action: :index}
      format.js
    end
  end

  def rules
  end

  def about

  end

  def login
    session[:auth_id] = nil
  end

  def callback
    user = Auth.where(provider: env['omniauth.auth'].provider ).find_by_uid env['omniauth.auth'].uid
    if user.nil?
      user = Auth.new(
          provider: env['omniauth.auth'].provider,
          uid: env['omniauth.auth'].uid,
          name: env['omniauth.auth'].info.name,
          data: env['omniauth.auth'].info.to_s
      )
      user.email = env['omniauth.auth'].info.email unless env['omniauth.auth'].info.email.blank?
      user.save
    end
    session[:auth_id] = user.id
    redirect_to action: :index
  end

  def final_stage
    if params[:post]
       @user.email = params[:post][:email]
       @user.is_subscribed = params[:post][:is_subscribed]
       @user.accepted_deal = params[:post][:accepted_deal]
       redirect_to action: :index if @user.save
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
     @user = Auth.find(session[:auth_id]) if session[:auth_id]
     redirect_to(action: 'final_stage') if params[:action] != 'final_stage' && !@user.nil? && @user.email.blank?
  end

  def get_tag
    @tag = Hashtag.active
    redirect_to action: 'blank' if @tag.nil?
  end

  def get_images(order,page = 1)
    case order
      when 'time' then order_by = '"created_at" DESC'
      when 'rate' then order_by = '"likes_count" DESC'
    end
    @images = @tag.images.order(order_by).page(page).per 24
  end
end
