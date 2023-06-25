class Header extends HTMLElement {
    connectedCallback() {
        this.innerHTML = `
        <header>
            <h1 id="title" title="Welcome to CLUBER!">CLUBER</h1>
            <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="hamburger">
                <path d="M4 18L20 18" stroke="#ffffff" stroke-width="2" stroke-linecap="round" />
                <path d="M4 12L20 12" stroke="#ffffff" stroke-width="2" stroke-linecap="round" />
                <path d="M4 6L20 6" stroke="#ffffff" stroke-width="2" stroke-linecap="round" />
            </svg>
            <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="exit-menu">
                <path d="M19 5L4.99998 19M5.00001 5L19 19" stroke="#ffffff" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round" />
            </svg>
        </header>
        `;
    }
}

customElements.define('header-component', Header);
