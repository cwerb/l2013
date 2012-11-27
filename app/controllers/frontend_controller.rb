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
          data: env['omniauth.auth'].info.to_s,
      )
    end
    user.session = Digest::MD5.hexdigest user.uid + Time.now.to_s
    session[:access] = user.session
    user.save
    redirect_to action: :index
  end

  def final_stage
    if request.post? and params[:user][:email]
       @user.email = params[:user][:email]
       @user.save
       redirect_to action: :index unless @user.errors.any?
    end
  end

  protected
  def authorise
     @user = Auth.find_by_session(session[:access]) if session[:access] && Auth.find_by_session(session[:access])
     redirect_to(action: 'final_stage') if params[:action] != 'final_stage' && @user && @user.email.blank?
  end

  def get_tag
    @tag = Hashtag.active
  end

  def drop
    session[:access] = nil
  end
end
