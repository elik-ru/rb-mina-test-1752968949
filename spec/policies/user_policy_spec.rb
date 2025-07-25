RSpec.describe UserPolicy do
  subject { described_class }

  let(:klass) { User }
  let(:object) { build(:user) }

  context "for guest user" do
    let(:user) { nil }

    permissions :index? do
      it { is_expected.to permit(user, klass) }
    end

    permissions :new?, :create? do
      it { is_expected.not_to permit(user, klass) }
    end

    permissions :show? do
      it { is_expected.to permit(user, object) }
    end

    permissions :edit?, :update?, :destroy?, :change_password?, :change_roles?, :impersonate? do
      it { is_expected.not_to permit(user, object) }
    end
  end

  context "for basic user" do
    let(:user) { build(:user) }

    permissions :index? do
      it { is_expected.to permit(user, klass) }
    end

    permissions :new?, :create? do
      it { is_expected.not_to permit(user, klass) }
    end

    permissions :show? do
      it { is_expected.to permit(user, object) }
    end

    permissions :change_password? do
      it { is_expected.to permit(user, user) }
    end

    permissions :edit?, :update?, :destroy?, :change_password?, :change_roles?, :impersonate? do
      it { is_expected.not_to permit(user, object) }
    end
  end

  context "for moderator user" do
    let(:user) { build(:user, :admin) }

    permissions :index?, :new?, :create? do
      it { is_expected.to permit(user, klass) }
    end

    permissions :show?, :edit?, :create?, :update?, :destroy? do
      it { is_expected.to permit(user, object) }
    end

    permissions :change_password? do
      it { is_expected.to permit(user, user) }
    end

    permissions :change_roles?, :change_password?, :impersonate? do
      it { is_expected.not_to permit(user, object) }
    end
  end

  context "for admin user" do
    let(:user) { build(:user, :admin) }

    permissions :index?, :new?, :create? do
      it { is_expected.to permit(user, klass) }
    end

    permissions :show?, :edit?, :create?, :update?, :destroy? do
      it { is_expected.to permit(user, object) }
    end

    permissions :change_password? do
      it { is_expected.to permit(user, user) }
    end

    permissions :change_roles?, :change_password?, :impersonate? do
      it { is_expected.not_to permit(user, object) }
    end
  end

  context "for superadmin user" do
    let(:user) { build(:user, :superadmin) }

    permissions :index?, :new?, :create? do
      it { is_expected.to permit(user, klass) }
    end

    permissions :change_password? do
      it { is_expected.to permit(user, user) }
    end

    permissions :show?, :edit?, :create?, :update?, :destroy?, :change_roles?, :change_password?, :impersonate? do
      it { is_expected.to permit(user, object) }
    end
  end
end
