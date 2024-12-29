import containerQueries from '@tailwindcss/container-queries';
import forms from '@tailwindcss/forms';
import typography from '@tailwindcss/typography';
import type { Config } from 'tailwindcss';
import daisyui from 'daisyui';

import { staticThemes } from 'rune-lab/themes';

export default {
  content: ['./src/**/*.{html,js,svelte,ts}',
    // * This lines are added to include rune-lab and daisyui components
    './node_modules/rune-lab/dist/**/*.{html,js,svelte,ts}',  // rune-lab components (import styles)
    './node_modules/daisyui/**/*.{html,js,svelte,ts}',  // daisyui components (import styles)
  ],

  theme: {
    extend: {}
  },

  plugins: [
    typography, 
    forms, 
    containerQueries,
    daisyui,
  ],

  daisyui: {
    themes: [...staticThemes],
    styled: true,  // component styling
    utils: true,  // util classes (bg-red-100, text-center, etc)
    logs: true,  // log info to console
    base: true,  // base components (button, input, etc)
    prefix: '',  // set a prefix for all daisyUI classes
  }
} satisfies Config;
