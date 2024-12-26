<script lang="ts">
	import '../app.css';
	let { children } = $props();
</script>

<!-- <svelte:head>
    <title>{$appName}</title>
    <meta name="application-name" content={$appName} />
</svelte:head> -->

{@render children()}
