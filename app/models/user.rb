# frozen_string_literal: true

class User < ApplicationRecord
  include LoggableActivity::Hooks

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to :demo_address, class_name: 'Demo::Address', foreign_key: :demo_address_id, optional: true
  belongs_to :demo_club, class_name: 'Demo::Club', foreign_key: :demo_club_id, optional: true
  has_many :patient_journals, class_name: 'Demo::Journal', foreign_key: 'patient_id', dependent: :nullify
  has_many :doctor_journals, class_name: 'Demo::Journal', foreign_key: 'doctor_id', dependent: :nullify
  has_one :demo_user_profile, class_name: 'Demo::UserProfile', dependent: :destroy
  accepts_nested_attributes_for :demo_user_profile
  enum user_type: { Patient: 0, Doctor: 1, Admin: 2 }

  def full_name
    "#{first_name} #{last_name}"
  end
end
