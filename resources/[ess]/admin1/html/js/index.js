function post(url, body, callback) {
    fetch(url, {
        method: 'POST',
        headers: {
            "Content-Type": "application/json;charset=utf8"
        },
        body: JSON.stringify(body || {})
    })
    .then(res => res.json())
    .then(res => {
        callback(res);
    });
}

const main = new Vue({
    el: "#main",
    data: {
        selected: undefined,
        items: undefined,
        showInventory: false,
        showToast: true,
        players: [],
        groups: [],
        toasts: [],
    },
    methods: {
        openPlayer(index) {
            post('/admin/getInfoFromSource', {
                source: index,
                name: this.players[index]
            }, (data) => {
                if (data.executed) {
                    main.selected = data;
                } else main.showErrorMessage("Failed fetching info of player.")
            });
        },
        openPlayerInventory() {
            if (this.selected !== undefined) {
                post('/admin/getInventoryFromSource', {
                    source: this.selected.source
                }, (data) => {
                    if (data.executed && main.selected.source === data.source) {
                        main.selected.inventory = data.inventory;
                        main.showInventory = true;
                    } else main.showErrorMessage("Failed fetching inventory of player.");
                });
            }
        },
        editInventoryItem(index) {
            let item = this.selected.inventory[index];
            this.$refs.itname.value = item.name;
            this.$refs.itcount.value = item.count;
        },
        updatePlayerList(players) {
            this.players = players;
            if (this.selected !== undefined && this.players[this.selected.source] === undefined) {
                this.selected = undefined;
            }
        },
        removePlayerFormList(index) {
            delete this.players[index];
            if (this.selected !== undefined && this.selected.source === index) {
                this.selected = undefined;
            }
        },
        give(type) {
            if (type === "item") {
                post('/admin/giveItem', {
                    source: this.selected.source,
                    name: this.$refs.itname.value,
                    amount: this.$refs.itcount.value
                }, (data) => {
                    if (data.executed) {
                        if (main.selected.inventory === undefined) return;
                        for (const index in main.selected.inventory) {
                            let item = main.selected.inventory[index];
                            if (item.name === data.name) {
                                item.count = data.count;
                            }
                        }
                        main.$forceUpdate()
                    } else main.showErrorMessage(data.message || "Error");
                })
            }
            else if (type === "money" || type === "bank") {
                post('/admin/giveAccount', {
                    source: this.selected.source,
                    amount: this.$refs[type].value,
                    account: type
                }, (data) => {
                    if (data.executed) {
                        main.selected.accounts[data.account] = data.current;
                    } else main.showErrorMessage(data.message || "Error");
                });
            }
        },
        remove(type) {
            if (type === "item") {
                post('/admin/removeItem', {
                    source: this.selected.source,
                    name: this.$refs.itname.value,
                    amount: this.$refs.itcount.value
                }, (data) => {
                    if (data.executed) {
                        if (main.selected.inventory === undefined) return;
                        for (const index in main.selected.inventory) {
                            let item = main.selected.inventory[index];
                            if (item.name === data.name) {
                                item.count = data.count;
                            }
                        }
                        main.$forceUpdate()
                    } else main.showErrorMessage(data.message || "Error");
                })
            }
            else if (type === "money" || type === "bank") {
                post('/admin/removeAccount', {
                    source: this.selected.source,
                    amount: this.$refs[type].value,
                    account: type
                }, (data) => {
                    if (data.executed) {
                        main.selected.accounts[data.account] = data.current;
                    } else main.showErrorMessage(data.message || "Error")
                });
            }
        },
        set(type) {
            if (type === "money" || type === "bank") {
                post('/admin/setAccount', {
                    source: this.selected.source,
                    amount: this.$refs[type].value,
                    account: type
                }, (data) => {
                    if (data.executed) {
                        main.selected.accounts[data.account] = data.current;
                    } else main.showErrorMessage(data.message || "Error")
                });
            }
            else if (type === "coords") {
                post('/admin/setCoords', {
                    source: this.selected.source,
                    coords: {
                        x: this.$refs.coordx.value,
                        y: this.$refs.coordy.value,
                        z: this.$refs.coordz.value,
                    }
                }, (data) => {
                    if (!data.executed) main.showErrorMessage(data.message || "Error");
                });
            }
            else if (type === "group") {
                post('/admin/setGroup', {
                    source: this.selected.source,
                    group: this.$refs.group.value
                }, (data) => {
                    if (data.executed) {
                        main.$refs.group.value = data.group;
                    } else main.showErrorMessage(data.message || "Error");
                })
            }
            else if (type === "name") {
                post('/admin/setName', {
                    source: this.selected.source,
                    firstname: this.$refs.firstname.value,
                    lastname: this.$refs.lastname.value
                }, (data) => {
                    if (data.executed) {
                        main.$refs.firstname.value = data.firstname;
                        main.$refs.lastname.value = data.lastname;
                    } else main.showErrorMessage(data.message || "Error");
                })
            }
        },
        kick(index) {
            post('/admin/kick', {
                source: index,
            }, (result) => {
                if (result.executed === true) {
                    main.removePlayerFormList(result.source);
                } else main.showErrorMessage(data.message || "Error");
            });
        },
        loadItems() {
            post('/admin/getInventoryFromSource', {
                source: this.selected.source
            }, (data) => {
                if (data.executed) {
                    let items = data.inventory
                    this.items = {};
                    for (const key in items) {
                        let item = items[key];
                        this.items[item.name] = item.label;
                    }
                } else main.showErrorMessage(data.message || "Error");
            });
        },
        validItem() {
            if (this.items === undefined) {this.loadItems(); return};
            let $ref = this.$refs.itname;
            if ($ref.value === '' || $ref.value === undefined) {
                $ref.style.backgroundColor = '';
            } else if (this.items[$ref.value] === undefined) {
                $ref.style.backgroundColor = '#dc3545';
            } else {
                $ref.style.backgroundColor = '#198754';
            }
        },
        showErrorMessage(msg) {
            this.toasts.push({message: msg, show: false});
            setTimeout(() => {
                main.toasts[this.toasts.length - 1].show = true;
            }, 150);
            setTimeout(function () {
                main.toasts.pop();
            }, 4750);
        },
        kill() {
            post('/admin/kill', {
                source: this.selected.source
            }, (data) => {
                if (!data.executed) main.showErrorMessage(data.message || "Error");
            });
        },
        respawn() {
            post('/admin/respawn', {
                source: this.selected.source
            }, (data) => {
                if (!data.executed) main.showErrorMessage(data.message || "Error");
            });
        }
    }
})

window.onload = function() {
    const events = new EventSource('/admin/updates');
    events.onmessage = (e) => {
        const players = JSON.parse(e.data).players
        if (players) {
            main.updatePlayerList(players);
        }
    }
}
