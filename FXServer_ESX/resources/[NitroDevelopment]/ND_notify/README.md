# ND Notifications
A simple notification system

![Image of Notification](https://i.imgur.com/shT1XWc.png)

## Use
To display a notification simply make a call like below (Client-Side) :

```lua
exports['ND_notify']:DoHudText('type', 'message')
```

### Notification Styles
* Inform - 'inform'
* Error - 'error'
* Success - 'success'

> Note About ID: This is expected to be an entirely unique value that your resource is responsible for tracking. I’d suggest using something related to your resource name so there’s no chance of interferring with any other persistent notifications that may exist.

### Custom Style Format -
The custom style is a simple array in key, value format where the key is the CSS style attribute and the value is whatever you want to set that CSS attribute to.

#### Examples -
##### Client:
```LUA
exports['ND_notify']:DoHudText('inform', 'Hype! Custom Styling!', { ['background-color'] = '#ffffff', ['color'] = '#000000' })
```

##### Server:
```LUA
TriggerClientEvent('ND_notify:client:SendAlert', source, { type = 'inform', text = 'Hype! Custom Styling!', style = { ['background-color'] = '#ffffff', ['color'] = '#000000' } })
```

##### Result:
![Custom Styling](https://i.imgur.com/FClWCqm.png)
