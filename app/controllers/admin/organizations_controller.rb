class Admin::OrganizationsController < ApplicationController
  before_action :user_signed_in
  before_action :admin_verify, except: :show
  before_action :load_organization, except: [:new, :create]
  skip_before_filter :verify_authenticity_token

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new organization_params
    if @organization.save
      flash[:success] = t("organization.create_success")
      redirect_to root_url
    else
      flash[:danger] = t("organization.create_fail")
      render :new
    end
  end

  def edit
  end

  def update
    if @organization.update_attributes organization_params
      flash[:success] = t "organization.update_success"
      redirect_to root_url
    else
      flash[:danger] = t "organization.update_fail"
      render :edit
    end
  end

  private
  def organization_params
    params.require(:organization).permit :name, :email, :phone,
      :location, :description
  end
end
