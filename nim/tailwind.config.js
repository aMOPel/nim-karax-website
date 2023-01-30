/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["app.js", "app.html"],
  theme: {
    colors: {
      transparent: "transparent",
      current: "currentColor",
      white: "#E6E8E6",
      grey: "#BFC4BF",
      black: "#080708",
      blue: "#3772FF",
      red: "#DF2935",
      yellow: "#FDCA40",
    },
    fontFamily: {
      sans: ['Inter var','ui-sans-serif','system-ui'],
      // serif: ['Merriweather', 'serif'],
    },
    extend: {
      typography: {
        DEFAULT: {
          css: {
            color: "#080708",
            a: {
              // "text-decoration-style": "dashed",
              "text-decoration-thickness": "10%",
              '&:hover': {
                "color": "#DF2935",
                "text-decoration-color": "#080708",
              },
            },
          },
        },
      },
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
