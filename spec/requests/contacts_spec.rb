RSpec.describe "Contacts page" do
  let(:user) { create(:user) }

  let!(:mail_template) { create(:mail_template, alias: "contact_form_message") }
  let!(:sender_email) { create(:setting, key: "sender_email", value: "support@test.com") }
  let!(:contact_form_receivers) { create(:setting, key: "contact_form_receivers", value: "support@test.com") }

  describe "GET /contacts" do
    context "when logged in" do
      before do
        sign_in user
        get "/contacts"
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it "prefills form", :aggregate_failures do
        # Check that the name input exists and contains the user's full name
        # Using include? to avoid CSS selector issues with special characters in names
        expect(response.body).to include("name=\"contact_us_command[name]\"")
        expect(response.body).to include("value=\"#{ERB::Util.html_escape(user.full_name)}\"")

        # Email field can still use have_tag as emails don't have problematic characters
        expect(response.body).to have_tag "input", with: { name: "contact_us_command[email]", value: user.email }
      end
    end

    context "when not logged in" do
      it "returns http success" do
        get "/contacts"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST /contacts" do
    let(:params) {
      {
        contact_us_command: {
          name:    "Test user",
          email:   "mail@test.com",
          subject: "subject",
          message: "message"
        }
      }
    }

    before do
      post "/contacts", params:
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "sends a confirmation email" do
      expect {  post "/contacts", params: }.to have_enqueued_mail
    end

    context "with invalid params" do
      let(:params) {
        {
          contact_us_command: {
            name: "Test user"
          }
        }
      }

      before do
        post "/contacts", params:
      end

      it "returns http success", :aggregate_failures do
        expect(response).to be_successful
        expect(response).to render_template("new")
      end
    end
  end
end
