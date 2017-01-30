class MetaData
  def initialize(options = {})
    @title       = options[:title]
    @description = options[:description]
    @keywords    = options[:keywords]
    @current_url = options[:current_url]
    @image       = 'http://res.cloudinary.com/viadeca/image/upload/v1485804369/basc_ncweef.jpg'
  end

  def seo
    # REPLACE THESE WITH REAL VALUES
    {
      site: 'Bay Area Social Club',
      title: @title,
      keywords: @keywords,
      description: @description,
      image_src: @image,
      author: "Teo Dell'Amico",
      canonical: 'http://basc.herokuapp.com',
      reverse: true,
      twitter: {
        card: 'summary_large_image',
        site: '@bayareasocialclub',
        title: @title,
        description: @description,
        image: @image
      },
      og: {
        title: @title,
        description: @description,
        url: @current_url,
        image: @image
      },
      icon: [
        { href: @image, sizes: '32x32 96x96', type: 'image/png' },
        { href: @image, rel: 'apple-touch-icon-precomposed', sizes: '32x32', type: 'image/png' }
      ]
    }
  end
end
