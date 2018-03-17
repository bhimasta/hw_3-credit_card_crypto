require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require 'minitest/autorun'

ciphers = [['Caesar', SubstitutionCipher::Caesar],
           ['Permutation', SubstitutionCipher::Permutation],
           ['Double Transposition', DoubleTranspositionCipher]]

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963',
                         'Mar-30-2020', 'Soumya Ray', 'Visa')
    @key = 3
  end

  ciphers.each do |chiper_name, cipher_module|
    describe "Using #{chiper_name} Cipher" do
      it 'should encrypt card information' do
        enc = cipher_module.encrypt(@cc, @key)
        enc.wont_equal @cc.to_s
        enc.wont_be_nil
      end

      it 'should decrypt text' do
        enc = cipher_module.encrypt(@cc, @key)
        dec = cipher_module.decrypt(enc, @key)
        dec.must_equal @cc.to_s
      end
    end
  end
end
