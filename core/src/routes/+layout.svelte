<!-- src/routes/+layout.svelte -->
<script lang="ts">
    import '../app.css';
    let { children } = $props();

    import { onMount } from 'svelte';
    import { appData, apiStore } from 'rune-lab';
    import { Footer, UrlDisplay, NavBar } from 'rune-lab';

    onMount(() => {  // Initialize main app data
        appData.init({  // Initialize app data
            name: 'GWA',
            version: 'v0.1.0',
            description: 'General Web Application Template',
            author: 'Yrrrrrf <fer.rezac@outlook.com>'
        });

        apiStore.init({  // Initialize API configuration
            // URL: import.meta.env.VITE_API_URL || 'http://localhost:8000',
            URL: 'http://localhost:8000',
            VERSION: 'v1',
            TIMEOUT: 30000
        });
    });

    // Meta tags derived from app data
    const metaTags = $derived([
        { name: 'application-name', content: appData.name },
        { name: 'author', content: appData.author },
        { name: 'description', content: appData.description },
    ]);
</script>

<svelte:head>
    <title>{appData.name}</title>
    {#each metaTags as meta}
        <meta name={meta.name} content={meta.content} />
    {/each}
</svelte:head>

<NavBar />

<div class="min-h-screen flex flex-col">
    <main class="flex-grow">
        {@render children()}
    </main>

    <Footer />
</div>

<UrlDisplay />
