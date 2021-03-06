class Players < ActiveRecord::Base
  @game_size = 2

  # adds a new user to the database and checks for valid name
  def self.add_user(name)
    new_player = Players.new

    new_player.player_id    = (name.nil?) ? 'Default Name' : name
    new_player.game_id      = -1
    new_player.game_outcome = false
    new_player.awk          = false
    new_player.pos          = -1

    new_player.save

    print('New Player: ',new_player.id,'\n')

    return new_player.id
  end

  #finds users who have been waiting the longest then
  #  gives them the same game id also generates a game id for a single
  #  user
  def self.gen_game(to_join)
    users = Players.where(:game_id => -1).order(:updated_at => :asc)

    is_single = Players.find_by_id(to_join)[:player_id] == '-2'

    if users.count >= @game_size && !is_single
      new_id = Players.maximum('game_id') + 1
      users.limit(@game_size).each { |user| user.game_id = new_id; user.save}
    elsif is_single
      new_id = Players.maximum('game_id') + 1
      p = Players.find_by_id(to_join)
      p[:game_id] = new_id
      p.save
    end

  end

  #determines if all users in a game are ready
  def self.ready(player_id)
     player = Players.find_by_id(player_id)
     player.awk = true
     player.save
  end

  #allows the user to be apart of another game
  def self.end_game(game_id)
    Players.where(:game_id => game_id).each { |user| user.game_id = -1; user.save}
  end

  def self.remove_user(user_id)

  end

end
