import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log("Theme controller connected");
    this.setThemeFromPreferences();
  }

  toggle() {
    console.log("Toggle theme");
    const currentTheme = document.body.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    document.body.setAttribute('data-theme', newTheme);

    localStorage.setItem('theme', newTheme);
  }

  setThemeFromPreferences() {
    const savedTheme = localStorage.getItem('theme') || 'light';
    console.log("Setting theme from preferences:", savedTheme);
    document.body.setAttribute('data-theme', savedTheme);
  }
}
