module Sharable
  extend ActiveSupport::Concern

  def root_key
    valid_types = User.subclasses.map { |u| u.name.underscore } + ['user']

    (params.keys & valid_types).first || :user
  end
end
