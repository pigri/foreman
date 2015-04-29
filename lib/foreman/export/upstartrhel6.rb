require "erb"
require "foreman/export"

class Foreman::Export::Upstartrhel6 < Foreman::Export::Base

  def export
    super

    engine.each_process do |name, process|

      next if engine.formation[name] < 1
      1.upto(engine.formation[name]) do |num|
        port = engine.port_for(process, num)
        process_file = "#{app}-#{name}.conf"
        clean File.join(location, process_file)
        write_template process_template, process_file, binding
      end
    end
  end

  private

  def process_template
    "upstartrhel6/process.conf.erb"
  end
end
