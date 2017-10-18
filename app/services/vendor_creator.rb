class VendorCreator
  def initialize(name, image, description)
    @name = name
    @image = image
    @description = description
  end

  def execute
    Vendor.create(name: name, slug: slug, image: image, description: description)
  end

  private
    attr_reader :name, :image, :description

    def slug
      name.parameterize
    end
end
