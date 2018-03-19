module DoubleTranspositionCipher
  # "{\"number\":\"4916603231464963\",\"expiration_date\":\"Mar-30-2020\",\"owner\":\"Soumya Ray\",\"credit_network\":\"Visa\"}"

  def self.col_len(doc)
    doc_len = doc.length
    (doc_len**(1.0 / 2)).round
  end

  def self.row_len(doc)
    doc_len = doc.length
    cols = col_len(doc)
    doc_len > cols**2 ? cols + 1 : cols
  end

  def self.stuff(doc, document, r_len, c_len)
    a_size = r_len * c_len
    (a_size - document.length).times do
      doc.last.push('#')
    end
  end

  def self.encrypt(document, key)
    document = document.to_s
    r_len = row_len(document)
    c_len = col_len(document)
    rand_gen = Random.new(key)
    r_order = (0..(r_len - 1)).to_a.shuffle(random: rand_gen)
    c_order = (0..(c_len - 1)).to_a.shuffle(random: rand_gen)
    doc = document.chars.each_slice(c_len).to_a
    stuff(doc, document, r_len, c_len)
    trans_doc = Array.new(r_len)
    r_order.each_with_index do |r, i|
      trans_doc[i] = doc[r]
    end
    result = Array.new(c_len, [])
    c_order.each_with_index do |c, i|
      result[i] = trans_doc.transpose[c]
    end
    result.transpose.join('')
  end

  def self.decrypt(ciphertext, key)
    r_len = row_len(ciphertext)
    c_len = col_len(ciphertext)
    rand_gen = Random.new(key)
    r_order = (0..(r_len - 1)).to_a.shuffle(random: rand_gen)
    c_order = (0..(c_len - 1)).to_a.shuffle(random: rand_gen)
    cip = ciphertext.chars.each_slice(c_len).to_a
    trans = Array.new(c_len)
    c_order.each_with_index do |c, i|
      trans[c] = cip.transpose[i]
    end
    result = Array.new(r_len)
    puts "r_order: #{r_order}"
    r_order.each_with_index do |r, i|
      result[r] = trans.transpose[i]
    end
    result.join('').delete! '#'
  end
end
