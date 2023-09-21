require 'rspec'
require_relative 'music_album'

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
end
