SitemapGenerator::Sitemap.default_host = "https://newpageintegritytravels.com"

SitemapGenerator::Sitemap.create do
  add about_path, changefreq: "monthly", priority: 0.8
  add visa_information_path, changefreq: "weekly", priority: 0.9
  add study_abroad_path, changefreq: "weekly", priority: 0.9
  add cac_services_path, changefreq: "weekly", priority: 0.9
  add services_path, changefreq: "weekly", priority: 0.9
  add destinations_path, changefreq: "weekly", priority: 0.9
  add blog_path, changefreq: "daily", priority: 0.8
  add gallery_path, changefreq: "weekly", priority: 0.7
  add testimonials_path, changefreq: "monthly", priority: 0.7
  add faqs_path, changefreq: "monthly", priority: 0.7
  add contact_path, changefreq: "monthly", priority: 0.8

  Service.published.find_each do |service|
    add service_path(slug: service.slug), lastmod: service.updated_at, priority: 0.8
  end

  Destination.published.find_each do |dest|
    add destination_path(slug: dest.slug), lastmod: dest.updated_at, priority: 0.8
  end

  BlogPost.published.find_each do |post|
    add blog_post_path(slug: post.slug), lastmod: post.updated_at, priority: 0.7
  end
end
