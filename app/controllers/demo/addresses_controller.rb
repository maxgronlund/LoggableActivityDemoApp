# frozen_string_literal: true

module Demo
  class AddressesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_address, only: %i[show edit update destroy]
    before_action :set_city, only: %i[show new edit update create destroy]

    # GET /demo/addresses or /demo/addresses.json
    def index
      @addresses = Demo::Address.all
    end

    # GET /demo/addresses/1 or /demo/addresses/1.json
    def show
      @address.log(:show)
    end

    # GET /demo/addresses/new
    def new
      @demo_city_options = Demo::City.all.map { |city| [city.name, city.id] }
      @address = Demo::Address.new
    end

    # GET /demo/addresses/1/edit
    def edit
      @demo_city_options = Demo::City.all.map { |city| [city.name, city.id] }
    end

    # POST /demo/addresses or /demo/addresses.json
    def create
      @address = Demo::Address.new(address_params)
      url = bounce_back_url(request)

      respond_to do |format|
        if @address.save
          format.html { redirect_to url, notice: 'Address was successfully created.' }
          format.json { render :show, status: :created, location: @address }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @address.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /demo/addresses/1 or /demo/addresses/1.json
    def update
      url = bounce_back_url(request)
      respond_to do |format|
        if @address.update(address_params)
          format.html { redirect_to url, notice: 'Address was successfully updated.' }
          format.json { render :show, status: :ok, location: @address }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @address.errors, status: :unprocessable_entity }
        end
      end
    end

    def destroy
      url = bounce_back_url(request)
      @address.destroy!

      respond_to do |format|
        format.html { redirect_to url, notice: 'Address was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private

    def bounce_back_url(request)
      return demo_addresses_url if @address.id.nil?
      return demo_addresses_url if @city.nil?
      return demo_addresses_url if request.referer == demo_address_url(@address)

      demo_city_url(@city)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_address
      @address = Demo::Address.find(params[:id])
    end

    def set_city
      return nil if params[:city_id].nil?

      @city = Demo::City.find(params[:city_id])
    end

    # Only allow a list of trusted parameters through.
    def address_params
      params.require(:demo_address).permit(:street, :postal_code, :demo_city_id)
    end
  end
end
