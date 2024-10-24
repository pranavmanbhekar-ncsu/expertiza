class RenameTeamsUsersToTeamParticipants < ActiveRecord::Migration[5.1]
  def change

    #Remove FKs from old table
    remove_foreign_key :teams_users, :participants
    remove_foreign_key :teams_users, :users
    remove_foreign_key :teams_users, :duties
    remove_foreign_key :teams_users, :teams

    # Remove the indexes from old table
    remove_index :teams_users, column: :user_id, name: "fk_teams_users"
    remove_index :teams_users, column: :team_id, name: "fk_users_teams"
    remove_index :teams_users, column: :participant_id, name: "fk_rails_7192605c92"
    remove_index :teams_users, column: :duty_id, name: "index_teams_users_on_duty_id"

    #first remove participant_id column
    remove_column :teams_users, :participant_id, :integer

    rename_table :teams_users, :teams_participants    
  
    # Rename the foreign key columns
    rename_column :teams_participants, :user_id, :participant_id

    # Add new indexes
    add_index :teams_participants, :team_id, name: "fk_participants_teams"
    add_index :teams_participants, :participant_id, name: "fk_teams_participants"
    add_index :teams_participants, :duty_id, name: "index_teams_participants_on_duty_id"

    # Add new foreign keys
    add_foreign_key :teams_participants, :duties
    add_foreign_key :teams_participants, :teams, name: "fk_participants_teams"
    add_foreign_key :teams_participants, :participants, name: "fk_teams_participants"
  end
end