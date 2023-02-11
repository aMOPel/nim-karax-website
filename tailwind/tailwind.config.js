/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["../dist/app.js", "../dist/index.html"],
  darkMode: "media",
  theme: {
    colors: {
      transparent: "transparent",
      current: "currentColor",
      white      : "#FFFCF2",
      grey       : "#CCC5B9",
      darkgrey   : "#403D39",
      black      : "#252422",
      red        : "#EB5E28",

      dmblack    : "#FFFCF2",
      dmdarkgrey : "#CCC5B9",
      dmgrey     : "#403D39",
      dmwhite    : "#252422",
      dmred      : "#EB5E28",
    },
    fontFamily: {
      sans: ['Inter var','ui-sans-serif','system-ui'],
      // serif: ['Merriweather', 'serif'],
    },
    extend: {
      typography: ({ theme }) => ({
        DEFAULT: {
          css: {
            '--tw-prose-body': theme('colors.black'),
            '--tw-prose-headings': theme('colors.black'),
            '--tw-prose-lead': theme('colors.black'),
            '--tw-prose-links': theme('colors.black'),
            '--tw-prose-bold': theme('colors.black'),
            '--tw-prose-counters': theme('colors.black'),
            '--tw-prose-bullets': theme('colors.black'),
            '--tw-prose-hr': theme('colors.black'),
            '--tw-prose-quotes': theme('colors.black'),
            '--tw-prose-quote-borders': theme('colors.black'),
            '--tw-prose-captions': theme('colors.black'),
            '--tw-prose-code': theme('colors.black'),
            '--tw-prose-pre-code': theme('colors.black'),
            '--tw-prose-pre-bg': theme('colors.white'),
            '--tw-prose-th-borders': theme('colors.black'),
            '--tw-prose-td-borders': theme('colors.black'),
            '--tw-prose-invert-body': theme('colors.dmblack'),
            '--tw-prose-invert-headings': theme('colors.dmblack'),
            '--tw-prose-invert-lead': theme('colors.dmblack'),
            '--tw-prose-invert-links': theme('colors.dmblack'),
            '--tw-prose-invert-bold': theme('colors.dmblack'),
            '--tw-prose-invert-counters': theme('colors.dmblack'),
            '--tw-prose-invert-bullets': theme('colors.dmblack'),
            '--tw-prose-invert-hr': theme('colors.dmblack'),
            '--tw-prose-invert-quotes': theme('colors.dmblack'),
            '--tw-prose-invert-quote-borders': theme('colors.dmblack'),
            '--tw-prose-invert-captions': theme('colors.dmblack'),
            '--tw-prose-invert-code': theme('colors.dmblack'),
            '--tw-prose-invert-pre-code': theme('colors.dmblack'),
            '--tw-prose-invert-pre-bg': theme('colors.dmwhite'),
            '--tw-prose-invert-th-borders': theme('colors.dmblack'),
            '--tw-prose-invert-td-borders': theme('colors.dmblack'),
            a: {
              '&:hover': {
                color: theme("colors.red"),
              }
            },
          },
        },
      }),
    },
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
