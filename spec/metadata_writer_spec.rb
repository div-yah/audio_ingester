require 'rspec'
require 'fileutils'
require_relative '../lib/metadata_writer'

describe MetadataWriter do
  let(:writer) { MetadataWriter.new(metadata, filepath) }
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

  describe '#xml_data' do
    let(:xml) do
      "<?xml version=\"1.0\" encoding=\"UTF-8\"?>"\
      "<track type=\"Audio\">"\
        "<format>PCM</format>"\
        "<channelCount>2</channelCount>"\
        "<samplingRate>44100</samplingRate>"\
        "<bitDepth>16</bitDepth>"\
        "<byteRate>176400</byteRate>"\
        "<bitRate>1411200</bitRate>"\
      "</track>"
    end

    it 'generates the corresponding xml data' do
      expect(writer.xml_data).to eq(xml)
    end
  end

  describe '#write_to_xml' do
    context 'when given valid item and file' do
      let(:output_path) { "output/#{Time.now.to_i}/valid.xml" }

      before do
        allow(writer).to receive(:generate_output_dir).and_return("output/#{Time.now.to_i}")
        allow(File).to receive(:open).and_yield(StringIO.new)
      end

      it 'saves the generated XML to output file' do
        expect(File).to receive(:open).with(output_path, 'w')

        writer.write_to_xml
      end
    end

    context 'when given invalid item or file' do
      let(:filepath) { nil }

      it 'raises an error' do
        expect { writer.write_to_xml }.to raise_error(MetadataWriterError)
      end
    end
  end
end
