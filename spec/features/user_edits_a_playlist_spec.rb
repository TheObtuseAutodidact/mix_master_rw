# As a user
# Given that a playlist and songs exist in the database
# When I visit that playlist's show page
# And I click on "Edit"
# And I enter a new playlist name
# And I select an additional song
# And I uncheck an existing song
# And I click on "Update Playlist"
# Then I should see the playlist's updated name
# And I should see the name of the newly added song
# And I should not see the name of the removed song

require 'rails_helper'

RSpec.feature "User can edit playlist" do
  scenario "they can change playlist name and content" do

    song_one, song_two, song_three, song_four, song_five = create_list(:song, 5)

    list_one = Playlist.create(name: "list_one", song_ids: [song_one.id, song_two.id, song_three.id])

    visit playlist_path(list_one)
    click_on 'Edit'
    save_and_open_page
    fill_in "playlist_name", with: "list one edit"
    uncheck ("song-#{song_two.id}")
    check ("song-#{song_four.id}")
    click_on "Update Playlist"


    expect(page).to have_content("list one edit")
    expect(page).to have_content(song_four.title)
    expect(page).not_to have_content(song_two.title)

  end
end
