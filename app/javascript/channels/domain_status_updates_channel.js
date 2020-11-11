import consumer from "./consumer"

window.enableDomainStatusUpdatesChannel = () => {
    consumer.subscriptions.create("DomainStatusUpdatesChannel", {
        connected() {
            // Called when the subscription is ready for use on the server
        },

        disconnected() {
            // Called when the subscription has been terminated by the server
        },

        received(data) {
            switch (data.type) {
                case 'finished':
                    Turbolinks.visit(window.location.toString(), { action: 'replace' });
                    break;

                case 'page_indexed':
                    document.getElementById("domain_" + data.id).innerText = data.title;
                    break;
            }
        }
    });
}