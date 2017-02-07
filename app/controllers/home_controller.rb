class HomeController < ApplicationController
  def index
    @page = params[:page] == nil ? 1 : params[:page]

    begin
      raise RestClient::ExceptionWithResponse if server_down?
      @resp = TeachbaseApi.new.get("/endpoint/v1/course_sessions?per_page=3&page=#{@page}").body

    rescue RestClient::ExceptionWithResponse
      @resp = get_courses_from_cache
      @server_condition = Rails.cache.write('server_is_down', true, expires_in: 1.minute)
      display_error
    else
      cache_data(@resp) if @page == 1
    ensure
      @courses = JSON.parse(@resp) || []
    end
  end

  private

  def cache_data(resp)
    Rails.cache.delete('server_is_down')
    Rails.cache.write('courses', resp)
    Rails.cache.write('server_request', Time.zone.now)
  end

  def get_courses_from_cache
    Rails.cache.read('courses') || ''
  end

  def get_time_from_cache
    Rails.cache.read('server_request')
  end

  def server_down?
    Rails.cache.read('server_is_down')
  end

  def server_down_hours
    ((Time.zone.now - get_time_from_cache) / 3600).round
  end

  def display_error
    error = 'В данный момент Teachbase недоступен.'
    error += " Загружена копия от #{get_time_from_cache}." if get_time_from_cache
    error += " Teachbase лежит уже #{server_down_hours} часов." if get_time_from_cache
    flash[:error] = error
  end
end
