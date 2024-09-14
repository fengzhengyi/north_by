import consumer from "channels/consumer"

consumer.subscriptions.create("ScheduleChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to ScheduleChannel")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
    console.log("Disconnected from ScheduleChannel")
  },

  received(data) {
    // Called when there's incoming data on the websocket for this channel
  }
});
