class RenameTeamsUsersToTeamParticipants < ActiveRecord::Migration[5.1]
  def change
    rename_table :teams_users, :teams_participants

    remove_column :team_participants, :participant_id, :integer

    # Rename the foreign key columns
    rename_column :team_participants, :user_id, :participant_id

    # Remove the old foreign keys
    remove_foreign_key :teams_users, :duties
    remove_foreign_key :teams_users, :participants
    remove_foreign_key :teams_users, :teams, name: "fk_users_teams"
    remove_foreign_key :teams_users, :users, name: "fk_teams_users"

    # Remove the old indexes
    remove_index :teams_participants, name: "fk_teams_users"
    remove_index :teams_participants, name: "fk_rails_7192605c92"
    remove_index :teams_participants, name: "index_teams_users_on_duty_id"
    remove_index :teams_participants, name: "fk_users_teams"

    # Add new indexes
    add_index :teams_participants, :team_id, name: "fk_teams_participants_team"
    add_index :teams_participants, :participant_id, name: "fk_team_participants_participant"
    add_index :teams_participants, :duty_id, name: "index_teams_participants_on_duty_id"

    # Add new foreign keys
    add_foreign_key :teams_participants, :duties
    add_foreign_key :teams_participants, :teams, name: "fk_participants_teams"
    add_foreign_key :teams_participants, :participants, name: "fk_teams_participants"
  end
end