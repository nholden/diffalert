class CreateEmailAddressesForTriggers < ActiveRecord::Migration[5.1]
  def change
    Trigger.all.each do |trigger|
      if email_address = EmailAddress.find_by(user_id: trigger.user_id, address: trigger.email)
        trigger.update! email_address_id: email_address.id
      else
        if User.find_by_id(trigger.user_id)
          trigger.create_email_address!(
            user_id: trigger.user_id,
            address: trigger.email,
            address_type: EmailAddress::ALERT_TYPE,
          )
          trigger.save!
        else
          trigger.delete
        end
      end
    end
  end
end
