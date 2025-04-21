# frozen_string_literal: true

class BaseService
  attr_reader :errors

  def initialize(**_args)
    @errors = []
  end

  def self.call(**args)
    new(**args).tap(&:call)
  end

  def success?
    errors.blank?
  end

  def failure?
    !success?
  end
end
