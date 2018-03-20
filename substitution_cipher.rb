# This module contains Caesar and Permutation encryption
module SubstitutionCipher
  # This module contains Caesar encryption
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      if key > 0
        document.to_s.chars.map { |d| (d.ord + key).chr }.join
      else
        caesar_error
      end
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      if key > 0
        document.to_s.chars.map { |d| (d.ord - key).chr }.join
      else
        caesar_error
      end
    end

    def caesar_error
      'Key must be positive integer'
    end
  end

  # This module contains Permutation encryption
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String

    def self.call_hash(key)
      ascii_table = (0..127).to_a.map(&:chr)
      Hash[ascii_table.zip ascii_table.shuffle(random: Random.new(key))]
    end

    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      p_hash = call_hash(key)
      key > 0 ? document.to_s.chars.map { |n| p_hash[n] }.join : caesar_error
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      p_hash = call_hash(key)
      key > 0 ? document.to_s.chars.map { |n| p_hash.key(n) }.join : caesar_error
    end
  end
end
