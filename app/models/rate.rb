class Rate < ApplicationRecord
    belongs_to :user
    belongs_to :product

    def product_rate(prod)
        @Rates = Rate.where(product_id: prod.id)
        tot_rate = 0
        @Rates.each do |rate|
            tot_rate += rate.rate
        end
        if reviewers(prod) > 0
            return prod_rate = (tot_rate/reviewers(prod))
        else
            return 0
        end
    end

    def reviewers(prod)
        Rate.where(product_id: prod.id).size
    end

    def check_rate(products, id)
        (products.rates).where(user_id: id).empty? 
    end

    def get_rate(products, id)
        (products.rates).find_by(user_id: id).rate
    end
end