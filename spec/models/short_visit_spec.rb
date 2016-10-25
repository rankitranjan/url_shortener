require 'rails_helper'

RSpec.describe ShortVisit, type: :model do

  let(:short_visit) { FactoryGirl.build(:short_visit) }

  it { should belong_to(:short_url) }

end
