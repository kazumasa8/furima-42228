require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'User Registration' do
    context 'Valid cases' do
      it 'registers successfully when all fields are correctly filled' do
        expect(@user).to be_valid
      end
    end

    context 'Invalid cases' do
      it 'fails to register when nickname is empty' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'fails to register when email is empty' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'fails to register when email is not unique' do
        @user.save
        another_user = FactoryBot.build(:user, email: @user.email)
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'fails to register when email does not contain @' do
        @user.email = 'testmail.com'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end

      it 'fails to register when password is empty' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'fails to register when password is less than 6 characters' do
        @user.password = 'a1b2'
        @user.password_confirmation = 'a1b2'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it 'fails to register when password consists only of numbers' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end

      it 'fails to register when password consists only of letters' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password must include both letters and numbers')
      end

      it 'fails to register when password and password confirmation do not match' do
        @user.password_confirmation = 'different'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'fails to register when last name is empty' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end

      it 'fails to register when first name is empty' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'fails to register when last name is not in full-width characters' do
        @user.last_name = 'Yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name must be in full-width characters')
      end

      it 'fails to register when first name is not in full-width characters' do
        @user.first_name = 'Rikutarou'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name must be in full-width characters')
      end

      it 'fails to register when last name in Kana is empty' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end

      it 'fails to register when first name in Kana is empty' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end

      it 'fails to register when last name in Kana is not in Katakana' do
        @user.last_name_kana = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana must be in Katakana')
      end

      it 'fails to register when first name in Kana is not in Katakana' do
        @user.first_name_kana = 'りくたろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana must be in Katakana')
      end

      it 'fails to register when birthday is empty' do
        @user.birthday = nil
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end
