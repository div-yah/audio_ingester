# This class reads metadata info of a wav format audio file
# Usage: MetadataReader.new(dir).read_from_wav

class MetadataReaderError < StandardError; end

class MetadataReader
  def initialize(filepath)
    @filepath = filepath
  end

  def read_from_wav
    extract
    {
      format: @raw_format == 1 ? 'PCM' : 'Compressed',
      channel_count: @channel_count,
      sampling_rate: @sampling_rate,
      bit_depth: @bit_depth,
      byte_rate: @byte_rate,
      bit_rate: @sampling_rate * @channel_count * @bit_depth
    }
  end

  private

  def extract
    File.open(@filepath) do |file|
      # For WAVE format with RIFF header, required metadata starts at offset of 20 bytes
      file.seek(20)

      # Decode metadata binary string with integer 16/32 bit format
      @raw_format, @channel_count, @sampling_rate, @byte_rate,_,@bit_depth = file.read(16).unpack("vvVVvv")
    end
  rescue StandardError => e
    raise MetadataReaderError.new("Error while reading #{@filepath}")
  end
end
