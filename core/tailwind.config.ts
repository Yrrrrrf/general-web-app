// import { availableThemes, customThemes } from './src/lib/stores/theme';
import containerQueries from '@tailwindcss/container-queries';
import forms from '@tailwindcss/forms';
import typography from '@tailwindcss/typography';
import type { Config } from 'tailwindcss';
import daisyui from 'daisyui';

// console.log('Tailwind config processing at:', new Date().toISOString());

export default {
  content: ['./src/**/*.{html,js,svelte,ts}'],

  theme: {
    extend: {}
  },

  plugins: [
    typography, 
    forms, 
    containerQueries,
    daisyui
  ],

  daisyui: {
    // themes: [...availableThemes, customThemes],
    themes: [
      'light', // first one is the default theme
      'dark'
    ],
    // styled: true,  // component styling
    // utils: true,  // util classes (bg-red-100, text-center, etc)
    // logs: true,  // log info to console
    // base: true,  // base components (button, input, etc)
    // prefix: '',  // set a prefix for all daisyUI classes
  }
} satisfies Config;
