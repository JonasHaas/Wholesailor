document.addEventListener("DOMContentLoaded", () => {
  fetchProducts();
  document.querySelector("#sync-button").addEventListener("click", syncProducts);
});

async function fetchProducts() {
  try {
      const response = await fetch("ncjejybxi3.execute-api.eu-central-1.amazonaws.com/prod/get-products");
      const data = await response.json();
      if (data.items.length === 0) {
          await processProducts();
          await fetchProducts();
      } else {
          displayProducts(data.items);
      }
  } catch (error) {
      console.error("Error fetching products:", error);
  }
}

async function processProducts() {
  try {
    const response = await fetch("ncjejybxi3.execute-api.eu-central-1.amazonaws.com/prod/process-products", { method: "POST" });
    const data = await response.json();
    console.log("Products processed:", data);
  } catch (error) {
    console.error("Error processing products:", error);
  }
}

function displayProducts(products) {
  const tableBody = document.querySelector("#products-table tbody");
  // Clear existing rows
  while (tableBody.firstChild) {
      tableBody.removeChild(tableBody.firstChild);
  }
  // Add new rows
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

async function syncProducts() {
  try {
      await processProducts();
      await fetchProducts();
      console.log("Sync complete");
  } catch (error) {
      console.error("Error syncing products:", error);
  }
}