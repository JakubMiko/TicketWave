module Admins
  class DashboardController < ApplicationController
    before_action :ensure_admin!

    def show
      # Pobierz dane potrzebne do wyświetlenia w widoku
      events = Event.all.limit(5) # Przykład: ostatnie 5 wydarzeń
      users = User.where(role: "user").limit(5) # Przykład: ostatnich 5 użytkowników
      statistics = {
        total_events: Event.count,
        total_users: User.where(role: "user").count,
        total_admins: User.where(role: "admin").count
      }

      # Renderuj widok z przekazaniem danych przez `locals`
      render "admins/dashboard/show", locals: { events: events, users: users, statistics: statistics }
    end

    private

    def ensure_admin!
      unless admin_signed_in? && current_admin&.admin?
        redirect_to new_admin_session_path, alert: "Musisz być zalogowany jako administrator, aby uzyskać dostęp do tej strony."
      end
    end
  end
end
