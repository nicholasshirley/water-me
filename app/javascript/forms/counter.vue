<template>
  <div class="is-tile is-ancestor">
    <div class="tile">
      <div class="tile is-parent is-4">
        <div class="tile is-child notification is-info">
          <article>
            <p class="title">Consumed so far today</p>
            {{ today.volume }}
          </article>
        </div>
      </div>

      <div class="tile is-parent is-4">
        <div class="tile is-child notification is-dark">
          <article>
            <form>
              <p class="title">Add volume</p>
              <div class="field is-grouped">
                <div class="control has-icons-left">
                  <input class="input" type="number" placeholder="Volume in ml" name="volume" v-model="volume">
                  <span class="icon is-small is-left">
                    <i class="fas fa-tint"></i>
                  </span>
                </div>

                <div class="control">
                  <button class="button is-link" @click="postOrPatch">Save</button>
                </div>
              </div>
            </form>
          </article>
        </div>
      </div>

      <div class="tile is-parent is-4">
        <div class="tile is-child notification box">
          <article>
            <p class="title">Add by favorite cup</p>
            Coming soon
          </article>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import axios from 'axios';

  export default {
    data: function() {
      return {
        volume: '',
      }
    },
    methods: {
      postOrPatch: function(e) {
        e.preventDefault
        if(this.today.id) {
          axios.patch(`/log_entries/${this.today.id}`, { 
            log_entry: {
              addition: true,
              volume: this.volume
            }
          }).then(function(response) {
            this.volume = response.volume
          })
        }
        else { 
          axios.post(`/log_entries`, {
            log_entry: {
              date: new Date(),
              volume: this.volume,
            }
          })
        }
      }
    },
    props: {
      today: {
        default: {},
        type: Object
      },
    }
  }
</script>