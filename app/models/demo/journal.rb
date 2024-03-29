# frozen_string_literal: true

module Demo
  class Journal < ApplicationRecord
    include LoggableActivity::Hooks
    belongs_to :patient, class_name: 'User'
    belongs_to :doctor, class_name: 'User'
    enum state: { pending: 0, accepted: 1, rejected: 2, closed: 3, archived: 4 }
  end
end
