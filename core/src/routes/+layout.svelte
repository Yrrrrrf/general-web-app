<script lang="ts">
	import '../app.css';
	let { children } = $props();

    import { 
        appData,
        // ThemeSelector,
        themeStore
     } from 'rune-lab';

    // Initialize app data
    appData.init({
        name: 'GWA',
        version: 'v0.1.0',
        author: 'Fernando Bryan Reza Campos'
    });

    // Initialize theme system
    // In the user's app

    themeStore.init();
</script>

<svelte:head>
    <title>{appData.name}</title>
    <meta name="application-name" content={appData.name} />
    <meta name="author" content={appData.author} />
</svelte:head>

{@render children()}
