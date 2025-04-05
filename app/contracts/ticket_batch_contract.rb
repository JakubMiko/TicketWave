class TicketBatchContract < ApplicationContract
  option :event
  option :existing_batches, default: -> { [] }

  params do
    optional(:id)
    required(:available_tickets).filled(:integer, gt?: 0)
    required(:price).filled(:decimal, gt?: 0)
    required(:sale_start).filled(:date_time)
    required(:sale_end).filled(:date_time)
  end

  rule(:sale_start, :sale_end) do
    if values[:sale_start] && values[:sale_end] && values[:sale_start] >= values[:sale_end]
      base.failure("Data rozpoczęcia sprzedaży musi być wcześniejsza niż data zakończenia")
    end
  end

  rule(:sale_end) do
    if value && event && event.date && value > event.date
      key.failure("musi być wcześniejsza niż data wydarzenia")
    end
  end

  rule(:sale_start, :sale_end) do
    if values[:sale_start] && values[:sale_end]
      existing_batches.each do |batch|
        next if values[:id] && batch.id == values[:id]

        if values[:sale_start] <= batch.sale_end && values[:sale_end] >= batch.sale_start
          base.failure("Okres sprzedaży koliduje z inną pulą biletów")
          break
        end
      end
    end
  end
end
