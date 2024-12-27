<script lang="ts">
  // import { gwaStore, closeModal } from 'rune-lab';
  // import { someFn } from '@rune-lab';

  // import { app_dt, forge_init } from 'ts-forge';
  import { init_lab } from 'rune-lab';
  import { UIShowcase } from 'rune-lab';


  let activeTab = $state(0);
  let progress = $state(0);

    // Progress bar simulation
  setInterval(() => {
    progress = (progress < 100 ? progress + 1 : 0);
  }, 100);

  $effect(() => {
    // document.documentElement.setAttribute('data-theme', 
    // gwaStore.darkMode ? 'dark' : 'light');
  });
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

  <!-- add a button that exec someFN -->
  <!-- <button onclick={() => forge_init()}>Click me</button> -->
  <!-- <button onclick={() => app_dt("")}>Click me</button> -->
  <button onclick={() => init_lab()}>Click me</button>

<!--  -->
  <div class="tabs">
      <button class="tab tab-lifted" class:active={activeTab === 0} onclick={() => activeTab = 0}>
          <span>Notifications</span>
      </button>
      <button class="tab tab-lifted" class:active={activeTab === 1} onclick={() => activeTab = 1}>
          <span>Modal</span>
      </button>
  </div>

</div>
