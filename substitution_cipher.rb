module SubstitutionCipher
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

  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def to_chr(ary)
      ary.map{|n|n.chr}
    end
    def self.encrypt(document, key)
      #create ascii array
      @ascii_table=to_chr((0..127).to_a)
      #create hash table with key
      @p_hash=Hash[ascii_table.zip ascii_table.shuffle(random: Random.new(key)) ]
      #map to encypted text
      encrypted_doc=document.to_s.chars.map{|n|p_hash[n]}.join
      # TODO: encrypt string using a permutation cipher
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      decrypted_doc=document.to_s.chars.map{|n|@p_hash.key(n)}.join
    end
  end
end
