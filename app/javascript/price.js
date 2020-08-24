window.addEventListener('load', function(){
 
  let addPrice = document.getElementById('add-tax-price')
  let benefit = document.getElementById('profit')
  let rawPrice = document.getElementById('item-price')
  rawPrice.addEventListener('keyup', () => { 
    rawPrice = document.getElementById('item-price').value
    let addPriceTax = Number(rawPrice) * 0.1
    let benefitFee = Number(rawPrice) - addPriceTax
      addPrice.innerHTML = Math.floor(addPriceTax)
        console.log(addPrice.innerHTML)
    
      benefit.innerHTML = Math.floor(benefitFee)
        console.log(benefit.innerHTML)
      })
 
  
})
