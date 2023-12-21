class UpdateStatusOfExistingTickets < ActiveRecord::Migration[7.0]
  def change
    Wish.where(stage: "review" || "Beta").update_all(stage: 'In process')
  end
end
