module ApplicationHelper
  def default_meta_tags
    {
        site: 'Locate-A-Brewery',
        title: 'Locate A Brewery',
        reverse: true,
        separator: '|',
        description: 'Locate a Brewery anywhere in the world',
        keywords: 'beer, brewery, bar, drink, drinks, craftbeer, craft beer,locate, brewery, locateabrewery, brewhouse, pub, breweries near ne, ipa, types of beer, beer stores near me, microbrewery, beer gardens, brew pubs, biergarten',
        noindex: !Rails.env.production?,
        icon: [
            { href: image_url('favicon.ico') },
            { href: image_url('icon.jpg'), rel: 'apple-touch-icon', sizes: '180x180', type: 'image/jpg' },
        ],
        og: {
            site_name: 'Locate-A-Brewery',
            title: 'Locate A Brewery',
            description: 'Locate a Brewery anywhere in the world',
            type: 'website',
            url: request.original_url,
            locale: 'en_US'
        },
        article: {
            tag: "#beer",
            tag: "#craftbeer",
            tag: "#brewery",
            tag: "#drink",
        }
    }
  end
end
