class ContactsController < ApplicationController
  skip_after_action :verify_authorized, only: [:new, :create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    @contact.save
    redirect_to root_path
  end

  private

  def contact_params
    params.require(:contact).permit(:email)
  end
end
