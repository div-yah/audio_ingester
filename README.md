# Audio Parser

This project parses metadata info of .wav files and writes to XML format output files.

# Usage

```
ruby audio_parser.rb input_files
```

# Prerequisities

```
gem install rspec gyoku
```

# Testing

Unit tests are set up for the `MetadataReader` and `MetadataWriter` classes with `rspec`. To run the tests, 

```
rspec
```
or
```
rspec spec/metadata_reader_spec.rb
rspec spec/metadata_writer_spec.rb
```

# Manual testing

```
gem install mediainfo
```
and in console,
```
require 'mediainfo'

media_info = MediaInfo.from(File.open('output/1709543076/sample-file-3.xml').read)

media_info.audio?             => true
media_indo.audio.bitdepth     => 16
media_info.audio.bitrate      => 1411200
media_info.audio.byterate     => 176400
media_info.audio.channelcount => 2
media_info.audio.count        => 1
media_info.audio.format       => "PCM"
media_info.audio.samplingrate => 44100
```
# Files

**Input**: Sample input files are stored in ``/input_files``

**Output**: Output XML files are written to `/output/#{timestamp.to_i}\`

**Spec files**: Sample files for testing are stored in `/spec/files`
