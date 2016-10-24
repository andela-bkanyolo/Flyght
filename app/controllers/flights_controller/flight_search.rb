class FlightsController
  class FlightSearch
    attr_reader :errors, :flights, :passengers, :date

    def initialize(origin, destination, passengers, date)
      @errors = []
      @flights = []
      @passengers = passengers
      @date = date
      check_route(origin, destination)
      check_date(date)
      get_flights(origin, destination) if @errors.empty?
    end

    private

    def check_route(origin, destination)
      if origin == destination
        @errors << "Origin and Destination airport cannot be the same."
      end
    end

    def check_date(date)
      begin
        @date = Time.parse(date)
        if @date < Time.now
          @errors << "Date cannot be same as or earlier than current date."
        elsif @date > Time.now + 1.year
          @errors << "Date cannot be later than one year from today."
        end
      rescue ArgumentError
        @errors << "Invalid date entered."
      end
    end

    def get_flights(origin, destination)
      @flights = Flight.from_to(origin, destination)
      @errors << "No flights available for this route." if @flights.empty?
    end
  end
end
