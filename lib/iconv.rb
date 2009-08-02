class Iconv

  @@ignore = /\/\/ignore$/i

  def initialize to, from
    @to   = to.sub @@ignore, ''
    @from = from.sub @@ignore, ''
    @opts = {}
    @opts[:undef]   = :replace if to   =~ @@ignore
    @opts[:invalid] = :replace if from =~ @@ignore
  end

  def close
    # do nothing
  end

  def iconv s
    s.force_encoding @from
    s.encode @to, @opts
  end

  def Iconv.open to, from
    i = Iconv.new to, from
    yield i
  end

  def Iconv.conv to, from, str
    i = Iconv.new to, from
    i.iconv str
  end

  def Iconv.iconv to, from, *strs
    i = Iconv.new to, from
    strs.map { |s| i.iconv s }
  end

end
