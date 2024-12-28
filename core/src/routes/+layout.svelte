<script lang="ts">
	import '../app.css';
	let { children } = $props();

    import { app } from 'rune-lab';

    // Initialize the store
    app.init({
        name: 'GWA',
        version: '0.1.0',
        author: 'Fernando Bryan Reza Campos'
    });

</script>

<svelte:head>
    <title>{$app.name}</title>
    <meta name="application-name" content={$app.name} />
</svelte:head>

{@render children()}
