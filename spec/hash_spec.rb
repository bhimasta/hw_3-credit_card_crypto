require_relative '../credit_card'
require 'minitest/autorun'
require 'yaml'

describe 'Test hashing requirements' do
  before do
    # Feel free to replace the contents of cards with data from your own yaml file
    yml_filepath = 'spec/fixtures/cc_results.yml'
    @card_details = YAML.safe_load(File.read(yml_filepath), [Symbol])
    @cards = @card_details.map do |c|
      CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
    end
  end

  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      it 'It should produced hashes consistently' do
        # TODO: Check that each card produces the same hash if hashed repeatedly
        @cards.each do |card|
          card.hash.wont_be_nil
          card.hash.wont_equal card.to_s
          card.hash.must_equal card.hash
        end
      end
    end

    describe 'Check for unique hashes' do
      it 'It should produced unique hashes' do
        # TODO: Check that each card produces a different hash than other cards
        @cards.each do |card|
          @cards.each do |card2|
            card.hash.wont_equal card2.hash if card != card2
          end
        end
      end
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      it 'It should produced secure hashes consistently' do
        # TODO: Check that each card produces the same hash if hashed repeatedly
        @cards.each do |card|
          card.hash_secure.wont_be_nil
          card.hash_secure.wont_equal card.to_s
          card.hash_secure.must_equal card.hash_secure
        end
      end
    end

    describe 'Check for unique hashes' do
      it 'It should produced unique hashes' do
        # TODO: Check that each card produces a different hash than other cards
        @cards.each do |card|
          @cards.each do |card2|
            card.hash_secure.wont_equal card2.hash_secure if card != card2
          end
        end
      end
    end

    describe 'Check regular hash not same as cryptographic hash' do
      it 'It should not produced the same hashes' do
        # TODO: Check that each card's hash is different from its hash_secure
        @cards.each do |card|
          card.hash.wont_equal card.hash_secure
        end
      end
    end
  end
end
