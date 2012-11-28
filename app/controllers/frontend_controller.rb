# -*- encoding : utf-8 -*-
class FrontendController < ApplicationController
  before_filter :drop, only: :login
  before_filter :authorise
  before_filter :get_tag, only: [:index, :rating]

  def index
    @images = @tag.images.page(params[:page])
  end

  def rating
    @images = @tag.images.order('"likes_count" DESC').page(params[:page])
  end

  def rules
  end

  def login
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
    end
    session[:auth_id] = user.id
    redirect_to action: :index
  end

  def final_stage
    if request.post?
       @user.email = params[:user][:email]
       @user.save
       redirect_to action: :index unless @user.errors.any?
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
    redirect_to action: 'blank'  if @tag.nil?
  end

  def drop
    session[:auth_id] = nil
  end
end
