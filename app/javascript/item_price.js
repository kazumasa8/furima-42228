const price = () => {  
  const priceInput = document.getElementById("item-price");
  const taxDom = document.getElementById("add-tax-price");
  const profitDom = document.getElementById("profit");

  if (!priceInput) return;

  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
     

    if (inputValue === "" || isNaN(inputValue)) {
      taxDom.innerHTML = "";
      profitDom.innerHTML = "";
      return;
    }

    const tax = Math.floor(inputValue * 0.1);
    taxDom.innerHTML = `${tax}`;

    const profit = inputValue - tax;
    profitDom.innerHTML = `${profit}`;
  });
};
window.addEventListener("turbo:load", price);
window.addEventListener("turbo:render", price);
