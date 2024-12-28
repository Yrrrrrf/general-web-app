<script lang="ts">
  import { UIShowcase } from 'rune-lab';

  import { init_forge } from 'ts-forge';

  import { app } from 'rune-lab';

</script>

<UIShowcase initialCount={5} />


<div class="min-h-screen bg-base-200 p-8">
  <div class="text-center mb-8">
      <h1 class="text-4xl font-bold text-base-content mb-2">UI Component Showcase</h1>
      <p class="text-base-content/70">
          <!-- Connected to API at: {gwaStore.apiUrl} -->
      </p>
  </div>
<!--  -->

  <!-- <button onclick={() => init_lab()}>RUNE-LAB</button> -->
  <button onclick={() => init_forge()}>TS-FORGE</button>

</div>

<h1>{$app.name} v{$app.version}</h1>
<p>By {$app.author}</p>