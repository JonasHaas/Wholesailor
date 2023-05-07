document.addEventListener("DOMContentLoaded", () => {
    fetchProducts();
  });
  
  async function fetchProducts() {
    try {
      const response = await fetch("http://localhost:5000/db");
      const data = await response.json();
      displayProducts(data.items);
    } catch (error) {
      console.error("Error fetching products:", error);
    }
  }
  
  function displayProducts(products) {
    const tableBody = document.querySelector("#products-table tbody");
  
    products.forEach((product) => {
      const row = document.createElement("tr");
  
      const idCell = document.createElement("td");
      idCell.textContent = product.id;
      row.appendChild(idCell);
  
      const nameCell = document.createElement("td");
      nameCell.textContent = product.name;
      row.appendChild(nameCell);
  
      const statusCell = document.createElement("td");
      statusCell.textContent = product.status;
      row.appendChild(statusCell);
  
      const skuCell = document.createElement("td");
      skuCell.textContent = product.sku;
      row.appendChild(skuCell);
  
      const isDropshipCell = document.createElement("td");
      isDropshipCell.textContent = product.isDropship;
      row.appendChild(isDropshipCell);
  
      const wholesalerNameCell = document.createElement("td");
      wholesalerNameCell.textContent = product.wholesalerName;
      row.appendChild(wholesalerNameCell);
  
      tableBody.appendChild(row);
    });
  }