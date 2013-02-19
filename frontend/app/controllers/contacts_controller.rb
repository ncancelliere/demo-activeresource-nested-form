class ContactsController < ApplicationController
  # GET /contacts
  # GET /contacts.json
  def index
    @contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @contacts }
    end
  end

  # GET /contacts/1
  # GET /contacts/1.json
  def show
    @contact = Contact.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/new
  # GET /contacts/new.json
  def new
    @contact = Contact.build  # NOTE: this was 'new'
    @emails = [Contact::Email.new]
    @addresses = [Contact::Address.new]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @contact }
    end
  end

  # GET /contacts/1/edit
  def edit
    @contact = Contact.find(params[:id])
    @emails = @contact.emails << Contact::Email.new
    @addresses = @contact.addresses << Contact::Address.new
  end

  # POST /contacts
  # POST /contacts.json
  def create
    @contact = Contact.build(sanitize_nested_params(params[:contact]))
    @emails = @contact.emails << Contact::Email.new
    @addresses = @contact.addresses << Contact::Address.new

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, notice: 'Contact was successfully created.' }
        format.json { render json: @contact, status: :created, location: @contact }
      else
        format.html { render action: "new", alert: @contact.errors.full_messages }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /contacts/1
  # PUT /contacts/1.json
  def update
    @contact = Contact.find(params[:id])
    @emails = @contact.emails << Contact::Email.new
    @addresses = @contact.addresses << Contact::Address.new

    respond_to do |format|
      if @contact.update_attributes(sanitize_nested_params(params[:contact]))
        format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit", alert: @contact.errors.full_messages }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1
  # DELETE /contacts/1.json
  def destroy
    @contact = Contact.find(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end
end
