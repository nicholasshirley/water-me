<template>
  <div>
    <div class="field">
      <label class="label">Entry Date</label>
      <div class="control has-icons-left">
        <datepicker id="date" name="date" placeholder="Pick the date" input-class="input"></datepicker>
        <span class="icon is-left is-small">
          <i class="fas fa-calendar-alt"></i>
        </span>
        <ul v-if="errors">
          <li v-for="error in errors.date" class="help is-danger">{{ error }}</li>
        </ul>
      </div>
    </div>

    <div class="field">
      <label class="label">Volume</label>
      <div class="control has-icons-left">
        <input :class="['input', errors.volume ? 'is-danger' : '']" id="volume" name="volume" type="number">
        <span class="icon is-small is-left">
          <i class="fas fa-tint"></i>
        </span>
        <ul v-if="errors">
          <li v-for="error in errors.volume" class="help is-danger">{{ error }}</li>
        </ul>
      </div>
    </div>

    <div class="field">
      <div class="control">
        <button class="button is-link">Submit</button>
      </div>
    </div>
  </div>
</template>

<script>
  import Datepicker from 'vuejs-datepicker';

  export default {
    data() {
      return {

      }
    },
    components: Datepicker,
    props: ["errors"],
  }
</script>