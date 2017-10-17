class Cart

  attr_reader :contents

  def initialize(initial_contents)
    @contents = initial_contents || Hash.new(0)
  end

  def count_of(item_id)
    contents[item_id.to_s]
  end

  def add_item(item_id)
    if contents[item_id.to_s]
      contents[item_id.to_s] += 1
    else
      contents[item_id.to_s] = 1
    end
  end

  def total_count
    contents.values.sum
  end

  def total_cost
    total = contents.reduce(0) do |total, item|
      total += Item.find(item[0]).price * count_of(item[0])
    end
    total / 100
  end

  def subtotal(item_id)
    (Item.find(item_id).price * count_of(item_id)) / 100
  end

  def remove_item(item_id)
    contents.delete(item_id.to_s)
  end

  def change_quantity(args_hash)
    item_id = args_hash[:item_id]
    if args_hash[:do] == "add"
      add_item(item_id)
    else
      contents[item_id] -= 1
    end
    if contents[item_id] == 0
      remove_item(item_id)
    end
  end

end
