class UrlBaseCollection
  def next_url
    raise NotImplementedError
  end

  def add_url(url)
    raise NotImplementedError
  end

  def size
    raise NotImplementedError
  end

  def empty?
    raise NotImplementedError
  end
end
