Spree.ready ($) ->
  Spree.updateVariantPrice = (variant) ->
    variantPrice = variant.data('price')
    variantCostPrice = variant.data('cost')
    variantPercentageProfit = variant.data('percentage-profit')
    ($ '.price.selling').text(variantPrice) if variantPrice
    ($ '.price.cost').text(variantCostPrice) if variantCostPrice
    ($ '.price.percentage').text(variantPercentageProfit) if variantPercentageProfit

  Spree.showHideVariants = (_this) ->
    selectedColorOption = $(_this).data('color-option-id')
    $("[data-select-color-option-id]").hide()
    sizeOptions = $("[data-select-color-option-id=" + selectedColorOption + "]").show()
    sizeOptions.first().find('input').trigger('click')

  Spree.productQuantityField = (_this) ->
    _this.value = parseInt(_this.value) if _this.value != ''
    _this.value = 1 if _this.value == 'NaN' || _this.value < 1

  Spree.productUpdateQuantity = (_this, quantity) ->
    if _this.value == ''
      _this.value = 1
    else
      _this.value = parseInt(_this.value) + quantity
    Spree.productQuantityField(_this)

  Spree.productUpdateQuantityFieldEvent = (_this, event) ->
    if(event.keyCode == 38)
      Spree.productUpdateQuantity(_this, 1)

    if(event.keyCode == 40)
      Spree.productUpdateQuantity(_this, -1)

  quantityField = ($ "[data-hook='product-quantity']")
  quantityField.bind 'input propertychange', (event) ->
    Spree.productQuantityField(this)
  quantityField.bind 'input keyup', (event) ->
    Spree.productUpdateQuantityFieldEvent(this, event)

  incrementQuantityField = $("[data-behaviour='increment-product-quantity']")
  incrementQuantityField.bind 'click', (event) ->
    Spree.productUpdateQuantity(quantityField[0], 1)

  decrementQuantityField = $("[data-behaviour='decrement-product-quantity']")
  decrementQuantityField.bind 'click', (event) ->
    Spree.productUpdateQuantity(quantityField[0], -1)

  colorOptions = $('[data-color-option-id]')
  colorOptions.bind 'click', (event) ->
    Spree.showHideVariants(this)
  Spree.showHideVariants(colorOptions[0])
