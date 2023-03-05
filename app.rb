require_relative 'services/time_formatter'

class App

  def call(env)
    @query = env['QUERY_STRING']
    @path = env['REQUEST_PATH']
    @received_format = (Rack::Utils.parse_nested_query(@query)).values.join.split(',')

    response
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def response
    return [ 404, headers, ["URL not found\n"] ] if @path != '/time'

    time_formater = TimeFormater.new(@received_format).call

    if time_formater.success?
      [ 200, headers, [time_formater.show_formated_time]
    else
      [ 400, headers, ["Unknown time format #{time_formater.unknown_time_formats}"]
    end  
  end

end
