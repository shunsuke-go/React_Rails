class ApplicationController < ActionController::Base
  befor_action :fake_load
  def fake_load
    sleep(1)
  end
end
