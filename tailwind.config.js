/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./pages/**/*.{js,ts,jsx,tsx}", "./components/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        'nn-bg': '#0B1220',
        'nn-surface': '#0F1724',
        'nn-cyan': '#00B5D8',
        'nn-purple': '#7C3AED',
        'nn-warm': '#FFB86B',
        'nn-muted': '#B9C6D8'
      },
      fontFamily: {
        sans: ['Inter', 'ui-sans-serif', 'system-ui']
      }
    }
  },
  plugins: []
};