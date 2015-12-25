# As a user
# Given that playlists exist in the database
# When I visit the playlists index
# Then I should see each playlist's name
# And each name should link to that playlist's individual page

require 'rails_helper'
RSpec.feature "User can view playlist index page and navigate to individual playlist show page" do
  scenario "they see the index page and click the link to see the show page" do
    song_one, song_two, song_three, song_four, song_five = create_list(:song, 5)

    list_one = Playlist.create(name: "list_one", song_ids: [song_one.id, song_two.id, song_three.id])
    list_two = Playlist.create(name: "list_two", song_ids: [song_four.id, song_five.id])
    visit playlists_path

    expect(page).to have_link(list_one.name, href: playlist_path(list_one))
    expect(page).to have_link(list_two.name, href: playlist_path(list_two))

    click_on list_one.name

    expect(page).to have_content( song_one.title )
    expect(page).to have_content( song_two.title )
    expect(page).to have_content( song_three.title )
    expect(current_path).to eq(playlist_path(list_one))
  end
end
