class Citation < ActiveRecord::Base
  belongs_to :cite, :polymorphic => true
end
