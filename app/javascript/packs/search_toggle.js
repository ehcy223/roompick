function setupSearchToggle() {
  document.querySelectorAll(".navbar-search").forEach(form => {
    const input  = form.querySelector('[data-behavior="search-input"]');
    const button = form.querySelector('[data-behavior="search-button"]');
    if (!input || !button) return;

    const toggle = () => {
      const hasText = (input.value || "").trim().length > 0;
      button.classList.toggle("is-hidden", !hasText);
    };

    // 初期表示 & イベント
    toggle();
    input.addEventListener("input", toggle);
  });
}

// Turbolinks 環境向け
document.addEventListener("turbolinks:load", setupSearchToggle);
// 非Turbolinksでも動くように保険
document.addEventListener("DOMContentLoaded", setupSearchToggle);