class TrackingEngineNotFound < Exception; end

# engines

module TrackMixpanel
  API_TOKEN = "71f1d0039f02a07e44e8306b0ef19b8b" # cappiello
   
  def insert_token(properties)
    properties.merge token: API_TOKEN
  end
  
  def with_mixpanel(event, properties={})
    @mixpanel = Mixpanel.new(API_TOKEN, properties[:request], true)
    properties.delete :request
    @mixpanel.track_event event, properties
  end
end

# core

module Tracking
  
  ENGINE = :mixpanel
  include TrackMixpanel if defined?(TrackMixpanel)
  
  def async(&block)
    #Thread.new{
      yield
    #}
  end
  
  def track(event, properties={})
    async do
      case ENGINE 
      when :mixpanel
        with_mixpanel event, properties
      else 
        raise TrackingEngineNotFound
      end
    end
  end
  
end