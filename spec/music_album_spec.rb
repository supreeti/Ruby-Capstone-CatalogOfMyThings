require 'rspec'
require_relative '../App/MusicAlbum/music_album'

def capture_stdout
  $stdout = StringIO.new
  yield
  $stdout.string
end

RSpec.describe MusicAlbum do
  before(:each) do
    MusicAlbum.class_variable_set(:@@all_albums, [])
    MusicAlbum.class_variable_set(:@@unique_genres, Set.new)
  end

  describe '.add_album' do
    it 'agrega un álbum a la lista de álbumes' do
      allow(MusicAlbum).to receive(:gets).and_return("Album Title\n", "Artist Name\n", "2023-09-21\n", "y\n", "Genre\n")
      MusicAlbum.add_album
      expect(MusicAlbum.class_variable_get(:@@all_albums)).not_to be_empty
    end
  end

  describe '.list_albums' do
    it 'muestra la lista de álbumes' do
      album = MusicAlbum.new('Test Album', 'Test Artist', '2023-09-21', true, 'Test Genre', true)
      MusicAlbum.class_variable_get(:@@all_albums) << album

      output = capture_stdout { MusicAlbum.list_albums }

      expect(output).to include('Test Album')
      expect(output).to include('Test Artist')
      expect(output).to include('Yes')
      expect(output).to include('Test Genre')
      expect(output).to include('Yes')
    end
  end

  describe '.load_data_if_needed' do
    it 'load data if it has not already been loaded' do
      expect { MusicAlbum.load_data_if_needed }.not_to raise_error
    end

    it 'does not load data if it has already been loaded' do
      MusicAlbum.instance_variable_set(:@loaded_data, true)
      expect { MusicAlbum.load_data_if_needed }.not_to(change { MusicAlbum.class_variable_get(:@@all_albums) })
    end
  end

  describe '.save_albums_to_json' do
    it 'save albums to a JSON file' do
      album = MusicAlbum.new('Test Album', 'Test Artist', '2023-09-21', true, 'Test Genre', true)
      MusicAlbum.class_variable_get(:@@all_albums) << album
      expect { MusicAlbum.save_albums_to_json }.not_to raise_error
    end
  end

  describe '.list_genres' do
    it 'list available genres' do
      genre_names = %w[Rock Pop Hip-Hop]
      genre_names.each { |name| MusicAlbum.class_variable_get(:@@unique_genres) << name }
      output = capture_stdout { MusicAlbum.list_genres }
      genre_names.each do |name|
        expect(output).to include(name)
      end
    end

    it 'shows a message if there are no genres available' do
      MusicAlbum.class_variable_set(:@@unique_genres, Set.new)
      output = capture_stdout { MusicAlbum.list_genres }
      expect(output).to include('no genres available')
    end
  end
end
