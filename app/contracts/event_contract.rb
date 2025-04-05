class EventContract < ApplicationContract
    params do
      required(:name).filled(:string)
      required(:description).filled(:string)
      required(:place).filled(:string)
      required(:category).filled(:string)
      required(:date).filled(:date_time)
      optional(:image)
    end

    rule(:date) do
      if value && value < DateTime.now
        key.failure("Data wydarzenia nie może być w przeszłości")
      end
    end
end
