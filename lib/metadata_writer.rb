require 'fileutils'
require 'gyoku'

# This class writes given metadata as xml to a custom output directory
# Usage: MetadataWriterr.new(metadata, file).write_to_xml

class MetadataWriterError < StandardError; end

class MetadataWriter
  def initialize(item, filepath)
    @item = item
    @filepath = filepath
  end

  def write_to_xml
    # Generate an output directory for every write call
    output_dir = generate_output_dir(Time.now.to_i)

    File.open(output_path(output_dir), 'w') { |f| f.write(xml_data) }
    puts "XML file succesfully generated for #{@filepath}"
  rescue => error
    raise MetadataWriterError.new("Error generating xml output for #{@filepath}")
  end

  def xml_data
    @item['@type'] = 'Audio'
    @xml_data ||= "<?xml version=\"1.0\" encoding=\"UTF-8\"?>#{Gyoku.xml({track: @item})}"
  end

  private

  def output_path(output_dir)
    "#{output_dir}/#{File.basename(@filepath, '.wav')}.xml"
  end

  def generate_output_dir(timestamp)
    # Output directory is generated if it doesn't already exist
    FileUtils.mkdir_p("output/#{timestamp}")[0]
  end
end
