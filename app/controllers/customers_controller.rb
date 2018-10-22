class CustomersController < ApplicationController
  before_action :check_login
  def show
    @cust = Customer.find(params[:id])
    render :show
  end
  def index
    @cust = Customer.all
    render :index
  end
  def edit
    @cust = Customer.find(params[:id])
    render :edit
  end
  def update
    cust = Customer.find(params[:id])
    cparam = params[:customer]
    cust.company = cparam[:company]
    cust.address = cparam[:address]
    cust.city = cparam[:city]
    cust.state = cparam[:state]
    cust.zip = cparam[:zip]
    cust.updated_at = DateTime.current.in_time_zone('UTC')
    if cust.save
      flash[:notice] = "Sucessfully Updated"
      redirect_to cust, status: 301
    else
      flash[:error] = "Error During Update"
      redirect_to edit_customer_path(params[:id]), status: 301
    end
  end
  def new
    @cust = Customer.new
    render :new
  end
  def create
    cust = Customer.new
    cparam = params[:customer]
    cust.company = cparam[:company]
    cust.address = cparam[:address]
    cust.city = cparam[:city]
    cust.state = cparam[:state]
    cust.zip = cparam[:zip]
    cust.updated_at = DateTime.current.in_time_zone('UTC')
    cust.created_at = cust.updated_at
    if  cust.save
      flash[:notice] = "Customer Created"
      redirect_to cust, status: 301
    else
      flash[:error] =  "Error: Create Failed"
      redirect_to new_customer_url, status: 301
    end
  end
  def destroy
    if(Customer.find(params[:id]).destroy)
      flash[:notice] =  'Successful Delete'
      redirect_to customers_path,status: 301
    else
      flash[:notice] = 'Error: Delete Failed'
      redirect_to customers_path,status: 301
    end
  end
end
