require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a valid user' do
      @user = User.new(
        name: 'Alan Rickman',
        email: 'snape@gmail.com',
        password: 'Lily',
        password_confirmation: 'Lily'
      )
      expect(@user).to be_valid
    end
    it 'should throw an error if name is empty' do
      @user = User.new(
        name: nil,
        email: 'alanrickman@gmail.com',
        password: 'Lily',
        password_confirmation: 'Lily'
      )
      expect(@user).to be_invalid
    end
    it 'should throw an error if email is empty' do
      @user = User.new(
        name: 'Alan Rickman',
        email: nil,
        password: 'Lily',
        password_confirmation: 'Lily'
      )
      expect(@user).to be_invalid
    end
    it 'should throw an error if password is shorter than 4 characters' do
      @user = User.new(
        name: 'Alan Rickman',
        email: 'alanrickman@gmail.com',
        password: 'abc',
        password_confirmation: 'abc'
      )
      expect(@user).to be_invalid
    end
    it 'should throw an error if password and password_confirmation do not match' do
      @user = User.new(
        name: 'Alan Rickman',
        email: 'alanrickman@gmail.com',
        password: 'abc',
        password_confirmation: '123'
      )
      expect(@user).to be_invalid
    end
    it 'should not allow a user to be created with a duplicate email' do
      @user1 = User.create(
        name: 'Alan Rickman',
        email: 'alanrickman2@gmail.com',
        password: 'abcd',
        password_confirmation: 'abcd'
      )

      @user2 = User.new(
        name: 'Alan Rickman',
        email: 'alanrickman2@gmail.com',
        password: 'abcd',
        password_confirmation: 'abcd'
      )
      expect(@user1).to be_valid
      expect(@user2).to be_invalid
      expect(@user2.errors.full_messages).to include ("Email has already been taken")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should authenticate a valid user' do
      @user = User.create(
        name: 'Doug Dimmadome',
        email: 'dougdimmadome@gmail.com',
        password: 'dimmadome',
        password_confirmation: 'dimmadome'
      )
      @user.save!
      expect(User.authenticate_with_credentials(@user.email, @user.password)).to eq(@user)
    end
    it 'should not authenticate when email is incorrect' do
      @user = User.create(
        name: 'Doug Dimmadome',
        email: 'dougdimmadome@gmail.com',
        password: 'dimmadome',
        password_confirmation: 'dimmadome'
      )
      @user.save!
      expect(User.authenticate_with_credentials("nottherightemail@gmail.com", @user.password)).to eq(nil)
    end
    it 'should not authenticate when password is incorrect' do
      @user = User.create(
        name: 'Doug Dimmadome',
        email: 'dougdimmadome@gmail.com',
        password: 'dimmadome',
        password_confirmation: 'dimmadome'
      )
      @user.save!
      expect(User.authenticate_with_credentials(@user.email, 'nottherightpassword')).to eq(nil)
    end
    it 'should authenticate a user if email is not in the right case' do
      @user = User.create(
        name: 'Doug Dimmadome',
        email: 'dougdimmadome@gmail.com',
        password: 'dimmadome',
        password_confirmation: 'dimmadome'
      )
      expect(User.authenticate_with_credentials('DougDiMMaDome@gmail.com', @user.password)).to eq(@user)
    end
    it 'should authenticate a user if email has whitespace and is not the right case' do
      @user = User.create(
        name: 'Doug Dimmadome',
        email: 'dougdimmadome@gmail.com',
        password: 'dimmadome',
        password_confirmation: 'dimmadome'
      )
      expect(User.authenticate_with_credentials('  DougDiMMaDome@gmail.com  ', @user.password)).to eq(@user)
    end
  end
end