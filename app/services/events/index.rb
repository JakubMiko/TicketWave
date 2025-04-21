module Events
  class Index < BaseService
    attr_reader :events

    def initialize
      super()
      @events = []
    end

    def call
      @events = fetch_events
      self
    end

    private

    def fetch_events
      Event.all
    rescue StandardError => e
      errors << "Nie udało się pobrać listy wydarzeń: #{e.message}"
    end
  end
end
