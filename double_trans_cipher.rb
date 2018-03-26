# DoubleTranspositionCipher
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    clen = col_len(document.to_s)
    rlen = row_len(document.to_s, clen)
    rand_gen = Random.new(key)
    r_order = shuffled(rlen, rand_gen)
    c_order = shuffled(clen, rand_gen)
    doc = slicing(document.to_s, rlen, clen)
    transposing(r_order, c_order, doc).transpose.join('')
  end

  def self.decrypt(ciphertext, key)
    clen = col_len(ciphertext.to_s)
    rlen = row_len(ciphertext, clen)
    rand_gen = Random.new(key)
    r_order = shuffled(rlen, rand_gen)
    c_order = shuffled(clen, rand_gen)
    cip = ciphertext.chars.each_slice(clen).to_a
    detransposing(r_order, c_order, cip)
  end

  def self.shuffled(len, rand)
    (0..(len - 1)).to_a.shuffle(random: rand)
  end

  def self.col_len(doc)
    (doc.length**0.5).round
  end

  def self.row_len(doc, clen)
    doc.length > clen**2 ? clen + 1 : clen
  end

  def self.slicing(document, rlen, clen)
    doc = document.chars.each_slice(clen).to_a
    a_size = rlen * clen
    (a_size - document.length).times { doc.last.push('#') }
    doc
  end

  def self.transposing(r_order, c_order, doc)
    r_order.each_with_index.map { |r, i| r_order[i] = doc[r] }
    c_order.each_with_index { |c, i| c_order[i] = r_order.transpose[c] }
  end

  def self.detransposing(r_order, c_order, cip)
    trans = []
    c_order.each_with_index { |c, i| trans[c] = cip.transpose[i] }
    result = []
    r_order.each_with_index { |r, i| result[r] = trans.transpose[i] }
    result.join('').delete! '#'
  end
end
