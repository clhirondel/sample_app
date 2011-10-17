#Encoding: UTF-8
require 'spec_helper'

describe Prospect do
  before(:each) do
      @user = Factory(:user)
      @attr = { :last_name => "Test Name",
      :first_name => "Test Name",
      :email => "test@test.fr",
      :phone_number_1 => "0123456789",
      :user_id => 1
    }
  end

  it "devrait créer instance de prospectus avec bons attributs" do
    @user.prospects.create!(@attr)
  end
  
  
  describe "associations avec l'utilisateur" do

    before(:each) do
      @prospect = @user.prospects.create(@attr)
    end

    it "devrait avoir un attribut user" do
      @prospect.should respond_to(:user)
    end

    it "devrait avoir le bon utilisateur associé" do
      @prospect.user_id.should == @user.id
      @prospect.user.should == @user
    end
  end
  
  describe "validations" do

    it "requiert un identifiant d'utilisateur" do
      Prospect.new(@attr).should_not be_valid
    end

    it "requiert un last_name non vide" do
      @user.prospects.build(:last_name => "  ").should_not be_valid
    end

    it "requiert un phone_number1 non vide" do
      @user.prospects.build(:phone_number_1 => "  ").should_not be_valid
    end
  
  it "devrait accepter une adresse email valide" do
    adresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
    adresses.each do |address|
      valid_email_prospect = @user.prospects.new(@attr.merge(:email => address))
      valid_email_prospect.should be_valid
    end
  end

  it "devrait rejeter une adresse email invalide" do
    adresses = %w[user@foo,com user_at_foo.org example.user@foo.]
    adresses.each do |address|
      invalid_email_prospect =  @user.prospects.new(@attr.merge(:email => address))
      invalid_email_prospect.should_not be_valid
    end
  end
  
   it "devrait accepter un numéro de téléphone valide" do
    numbers = %w[0153789999 01-53-78-99-99 01.53.78.99.99]
    numbers.each do |number|
      valid_phonenumber_prospect =  @user.prospects.new(@attr.merge(:phone_number_1 => number))
      valid_phonenumber_prospect.should be_valid
    end
  end

   it "devrait rejeter un numéro de téléphone invalide" do
      numbers = %w[233424034 01 231422]
      numbers.each do |number|
      invalid_phonenumber_prospect = @user.prospects.new(@attr.merge(:phone_number_1 => number))
      invalid_phonenumber_prospect.should_not be_valid
    end
   end
    
   it "devrait rejeter un numéro de téléphone double" do
      # Place un utilisateur avec un email donné dans la BD.
      @user.prospects.create!(@attr)
      prospect_with_duplicate_phonenumber = @user.prospects.new(@attr)
      prospect_with_duplicate_phonenumber.should_not be_valid
   end
  end
end
