# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :first_name,               limit: 255,   default: "", null: false
      t.string :last_name,                limit: 255,   default: "", null: false
      t.string :email,                                  default: "", null: false
      t.string :encrypted_password,                     default: "", null: false

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count,          limit: 8,   default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip,     limit: 255
      t.string   :last_sign_in_ip,        limit: 255

      #Invitation
      t.string   :invitation_token,       limit: 255
      t.datetime :invitation_created_at
      t.datetime :invitation_sent_at
      t.datetime :invitation_accepted_at
      t.integer  :invitation_limit,       limit: 8
      t.integer  :invited_by_id,          limit: 8
      t.string   :invited_by_type,        limit: 255
      t.integer  :invitations_count,      limit: 8,   default: 0

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at


      t.timestamps null: false

      t.integer  "db_show_todos_days",                 default: 60,    null: false
      t.boolean  "assignable",                         default: false, null: false
      t.boolean  "is_active",                          default: true
    end

    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true
  end
end
