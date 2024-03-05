require_relative 'lib/metadata_reader'
require_relative 'lib/metadata_writer'

class AudioParser
  def initialize(filepath)
    @filepath = filepath
  end

  def parse_wav_files
    Dir.glob("#{@filepath}/**/*.wav").each do |file|
      item = MetadataReader.new(file).read_from_wav
      MetadataWriter.new(item, file).write_to_xml
    end
  end
end

input_dir = ARGV[0]

if Dir.exist?(input_dir)
  AudioParser.new(input_dir).parse_wav_files
else
  puts 'Invalid input directory'
end
