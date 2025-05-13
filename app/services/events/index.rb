# frozen_string_literal: true

module Events
  class Index < BaseService
    attr_reader :events

    def call
      @events = fetch_events
    end

    private

    def fetch_events
      Event.upcoming
    end
  end
end
