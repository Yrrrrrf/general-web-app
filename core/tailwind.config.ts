// import { availableThemes, customThemes } from './src/lib/stores/theme';
import containerQueries from '@tailwindcss/container-queries';
import forms from '@tailwindcss/forms';
import typography from '@tailwindcss/typography';
import type { Config } from 'tailwindcss';


export default {
  content: ['./src/**/*.{html,js,svelte,ts}'],

  theme: {
    extend: {}
  },

  plugins: [
    typography, 
    forms, 
    containerQueries,
    require('daisyui')
  ],

  daisyui: {
    themes: [
      // themes: [...availableThemes, customThemes],
      'light', // first one is the default theme
      'dark'
    ],
    styled: true,
    utils: true,
    logs: true,
    base: true,
    prefix: '',
    darkTheme: 'dark'
  }
} satisfies Config;
