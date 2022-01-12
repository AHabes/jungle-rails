require 'rails_helper'

# "name"
#     t.string   "email"
#     t.string   "password_digest"
  describe 'Validations' do

      it "validates first name" do
        @user = User.new(first_name: nil, last_name: "EFG", email: "abc@example.com", password: "12345678", password_confirmation: '12345678')
        @user.save
        expect(@user.errors.full_messages.to_sentence).to include("First name can't be blank")
        expect(@user).to_not be_valid
      end

      it "validates last name" do
        @user = User.new(first_name: "ABC", last_name: nil, email: "abc@example.com", password: "12345678", password_confirmation: '12345678')
        @user.save
        expect(@user.errors.full_messages.to_sentence).to include("Last name can't be blank")
        expect(@user).to_not be_valid
      end

      it "validates email" do
        @user = User.new(first_name: "ABC", last_name: "EFG", email: nil, password: "12345678", password_confirmation: '12345678')
        @user.save
        expect(@user.errors.full_messages.to_sentence).to include("Email can't be blank")
        expect(@user).to_not be_valid
      end

      it "validates password" do
        @user = User.new(first_name: "ABC", last_name: "EFG", email: "abc@example.com", password: nil, password_confirmation: '456')
        @user.save
        expect(@user.errors.full_messages.to_sentence).to include("Password can't be blank")
        expect(@user).to_not be_valid
      end

      it "validates passwords match" do
        @user = User.new(first_name: "ABC", last_name: "EFG", email: "abc@example.com", password: "12345678", password_confirmation: '87654321')
        @user.save
        expect(@user.errors.full_messages.to_sentence).to include("Password confirmation doesn't match Password")
        expect(@user).to_not be_valid
      end


      it "validates passwords length at least 8 characters" do
        @user = User.new(first_name: "ABC", last_name: "EFG", email: "abc@example.com", password: "1", password_confirmation: '1')
        @user.save
        expect(@user.errors.full_messages.to_sentence).to include("Password is too short (minimum is 8 characters")
        expect(@user).to_not be_valid
      end

      it "validates email uniqueness" do
        @user1 = User.new(first_name: "ABC", last_name: "EFG", email: "abc@example.com", password: "12345678", password_confirmation: '12345678')
        @user1.save

        expect(@user1).to be_valid

        @user2 = User.new(first_name: "HIJ", last_name: "KLM", email: "abc@example.com", password: "12345678", password_confirmation: '12345678')
        @user2.save

        expect(@user2.errors.full_messages.to_sentence).to include("Email has already been taken")
        expect(@user2).to_not be_valid
      end

  end

  describe '.authenticate_with_credentials' do
    it "validates user login" do
        @user1 = User.new(first_name: "ABC", last_name: "EFG", email: "abc@example.com", password: "12345678")
        @user1.save
        @result = User.authenticate_with_credentials(@user1.email, @user1.password)
        expect(@result).to be_valid
    end

    it "validates user can not login with wrong password" do
        @user = User.new(first_name: "ABC", last_name: "EFG", email: "abc@example.com", password: "12345678")
        @user.save
        @result = User.authenticate_with_credentials("abc@example.com", "87654321")
        expect(@result).to be_nil
    end

    it "validates email is case insensitive" do
        @user = User.new(first_name: "ABC", last_name: "EFG", email: "ABC@EXAMPLE.COM", password: "12345678")
        @user.save!
        @result = User.authenticate_with_credentials("abc@example.com", "12345678")
        expect(@result).to be_valid
    end

    it "validates spaces not allowed in the email" do
        @user = User.new(first_name: "ABC", last_name: "EFG", email: "ABC@EXAMPLE.COM", password: "12345678")
        @user.save!
        @result = User.authenticate_with_credentials("    abc@example.com    ", "12345678")
        expect(@result).to be_nil
    end

  end
