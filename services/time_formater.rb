class TimeFormater

  FORMATS = { 
              year: '%Y',
              month: '%m',
              day: '%d',
              hour: '%H',
              minute: '%M',
              second: '%S' 
            }.freeze

  attr_reader :unknown_time_formats

  def initialize(received_format)
    @received_format = received_format
    @known_time_formats = []
    @unknown_time_formats = []
  end

  def call
    check_format
  end

  def success?
    @received_format.split(', ').count == @known_time_formats.count
  end

  def check_format
    @received_format.split(', ').each do |format|
      if FORMATS.has_key?(format.to_sym)
        @known_time_formats << @FORMATS[format.to_sym]
      else
        @unknown_time_formats << format
      end
    end 
  end

  def show_formated_time
    Time.now.strftime(@known_time_formats.join('-'))
  end
end
