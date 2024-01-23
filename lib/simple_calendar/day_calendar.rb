# frozen_string_literal: true

# lib/simple_calendar/day_calendar.rb

module SimpleCalendar
  # DayCalendar class implementation
  class DayCalendar < SimpleCalendar::Calendar
    attr_reader :options, :params

    def initialize(view, options = {}, params = {})
      super(view, options)

      @params = params
    end

    def number_of_days
      options.fetch(:number_of_days, 1)
    end

    def end_date
      start_date + (number_of_days - 1).days
    end

    def date_range
      (start_date..end_date).to_a
    end

    def url_for_previous_view
      view_context.url_for(@params.merge(start_date_param => (start_date - 1.day).iso8601, :view => 'day'))
    end

    def url_for_next_view
      view_context.url_for(@params.merge(start_date_param => (end_date + 1.day).iso8601, :view => 'day'))
    end

    private

    def start_date_param
      options.fetch(:start_date_param, 'start_date')
    end
  end
end
