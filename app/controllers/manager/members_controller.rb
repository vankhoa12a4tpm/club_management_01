class Manager::MembersController < BaseOrganizationManagerController
  before_action :load_user_organization, only: :update

  def index
    @users = @organization.user_organizations.joined
  end

  def show
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t("not_found_user")
      redirect_to request.referrer
    end
    @organizations = @user.organizations
    @user_organization = UserOrganization.find_with_user_of_company params[:id],
      params[:organization]
  end

  def update
    if params[:status].blank?
      user = @user.update_attributes is_admin: true
    else
      user = @user.update_attributes status: params[:status].to_i
    end
    unless user
      flash[:danger] = t("error_process")
      redirect_to :back
    end
    flash[:success] = t("success_process")
    redirect_to :back
  end

  private
  def load_user_organization
    @user = UserOrganization.find_by id: params[:id]
    unless @user
      flash[:danger] = t("user_organization_not_found")
      redirect_to request.referrer
    end
  end
end
