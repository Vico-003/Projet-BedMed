document.addEventListener("DOMContentLoaded", () => {
  const modal = document.querySelector(".modal-overlay");
  const modalTitle = document.getElementById("modal-title");
  const cancelBtn = document.getElementById("cancel-btn");
  const form = document.getElementById("dynamic-form");
  const formFields = document.getElementById("form-fields");
  const tableBody = document.querySelector(".data-table tbody");

  const fieldTemplates = {
    patient: [
      { name: "nom", placeholder: "Nom", type: "text" },
      { name: "dateNaissance", placeholder: "Date de naissance", type: "date" },
      { name: "adresse", placeholder: "Adresse", type: "text" },
    ],
    soignant: [
      { name: "nom", placeholder: "Nom", type: "text" },
      { name: "specialite", placeholder: "Spécialité", type: "text" },
      { name: "telephone", placeholder: "Téléphone", type: "text" },
    ],
    intervention: [
      { name: "type", placeholder: "Type d'intervention", type: "text" },
      { name: "date", placeholder: "Date", type: "date" },
      { name: "patient", placeholder: "Nom du patient", type: "text" },
      { name: "soignant", placeholder: "Nom du soignant", type: "text" },
    ],
  };

  // Boutons "Ajouter Patient" et "Ajouter Soignant"
  document.querySelectorAll(".add-btn").forEach((button) => {
    button.addEventListener("click", () => {
      const type = button.dataset.type;
      form.setAttribute("data-type", type);
      modalTitle.textContent = `Ajouter ${
        type.charAt(0).toUpperCase() + type.slice(1)
      }`;
      formFields.innerHTML = "";

      fieldTemplates[type].forEach((field) => {
        const input = document.createElement("input");
        input.type = field.type;
        input.name = field.name;
        input.placeholder = field.placeholder;
        input.required = true;
        formFields.appendChild(input);
      });

      modal.style.display = "flex";
    });
  });

  // Fermer la modale
  cancelBtn.addEventListener("click", () => {
    modal.style.display = "none";
    form.reset();
  });

  // Soumettre le formulaire
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const type = form.getAttribute("data-type");
    const formData = new FormData(form);

    let tr = document.createElement("tr");

    if (type === "patient") {
      const nom = formData.get("nom");
      const dateNaissance = formData.get("dateNaissance");
      const adresse = formData.get("adresse");

      tr.innerHTML = `
        <td data-label="Nom">${nom}</td>
        <td data-label="Date de naissance">${dateNaissance}</td>
        <td data-label="Adresse">${adresse}</td>
        <td data-label="Actions">
          <div class="table-buttons">
            <button class="action-btn">Détails</button>
            <button class="btn-delete">Supprimer</button>
          </div>
        </td>
      `;
    }

    if (type === "soignant") {
      const nom = formData.get("nom");
      const specialite = formData.get("specialite");
      const telephone = formData.get("telephone");

      tr.innerHTML = `
        <td data-label="Nom">${nom}</td>
        <td data-label="Spécialité">${specialite}</td>
        <td data-label="Téléphone">${telephone}</td>
        <td data-label="Actions">
          <div class="table-buttons">
            <button class="action-btn">Détails</button>
            <button class="btn-delete">Supprimer</button>
          </div>
        </td>
      `;
    }

    if (type === "intervention") {
      const interventionType = formData.get("type");
      const date = formData.get("date");
      const patient = formData.get("patient");
      const soignant = formData.get("soignant");

      tr.innerHTML = `
        <td data-label="Type">${interventionType}</td>
        <td data-label="Date">${date}</td>
        <td data-label="Patient">${patient}</td>
        <td data-label="Soignant">${soignant}</td>
        <td data-label="Actions">
          <div class="table-buttons">
            <button class="action-btn">Détails</button>
            <button class="btn-delete">Supprimer</button>
          </div>
        </td>
      `;
    }
    

    tr.querySelector(".btn-delete").addEventListener("click", () => {
      if (confirm(`Supprimer ce ${type} ?`)) {
        tr.remove();
      }
    });

    tableBody.appendChild(tr);
    modal.style.display = "none";
    form.reset();
  });

  // Suppression des lignes déjà présentes
  document.querySelectorAll(".btn-delete").forEach((btn) => {
    btn.addEventListener("click", () => {
      if (confirm("Supprimer cette entrée ?")) {
        btn.closest("tr").remove();
      }
    });
  });
});

document.addEventListener("DOMContentLoaded", () => {
  const searchInput = document.getElementById("search-input");
  const tableBody = document.querySelector(".data-table tbody");

  if (searchInput && tableBody) {
    searchInput.addEventListener("input", () => {
      const filter = searchInput.value.toLowerCase();

      Array.from(tableBody.querySelectorAll("tr")).forEach(row => {
        const rowText = row.textContent.toLowerCase();
        row.style.display = rowText.includes(filter) ? "" : "none";
      });
    });
  }
});

