require 'factory_girl'
FactoryGirl.find_definitions

use_manual_close


account :scott,  FactoryGirl.create(:scott_key_pair)
account :bartek, FactoryGirl.create(:bartek_key_pair)
account :andrew, FactoryGirl.create(:andrew_key_pair)

create_account :scott,  :master, 1000_000000
create_account :bartek, :master, 1000_000000
create_account :andrew, :master, 1000_000000

close_ledger

payment :scott, :andrew,  [:native, 50_000000]
