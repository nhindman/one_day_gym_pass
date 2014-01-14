require 'spec_helper'

describe "Passes" do
  describe "Given that I visit users path" do
    before do
      visit users_path
      @user_input_address = "345 Buckminster Road, Brookline, MA"
    end

    describe "When I fill in the address form" do
      before do
      fill_in "user_input_address", with: @user_input_address
      find_button("Find gyms").click
      end
      it "should display local gyms" do
        current_path.should == passes_path
        page.should have_content(@items)
      end
      describe "And I select a local gym by clicking the link on its name" do
        click_link 'Equinox'
        it "should take us to the gym's page" do
          pending
        end
      end
    end

  end
end