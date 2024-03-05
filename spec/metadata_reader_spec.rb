require 'rspec'
require_relative '../lib/metadata_reader'

describe MetadataReader do
  let(:reader) { MetadataReader.new(filepath) }

  describe '#read_from_wav' do
    context 'when given a valid WAV file' do
      let(:filepath) { 'spec/files/valid.wav' }
      let(:metadata) do
        {
          format: "PCM",
          channel_count: 2,
          sampling_rate: 44100,
          bit_depth: 16,
          byte_rate: 176400,
          bit_rate: 1411200
        }
      end

      it 'reads the WAV file and returns a valid hash' do
        expect(reader.read_from_wav).to eq(metadata)
      end
    end

    context 'when given an invalid WAV file' do
      let(:filepath) { 'spec/files/invalid.wav' }

      it 'raises an error' do
        expect { reader.read_from_wav }.to raise_error(MetadataReaderError)
      end
    end
  end
end
