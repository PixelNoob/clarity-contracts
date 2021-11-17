import requests as r
import json

headers = {'content-type': 'application/json'}

# numbers in clarity hex
numbers = ['0x0000000000000000000000000000000000', '0x0000000000000000000000000000000001', '0x0000000000000000000000000000000002']

# put id number in argument in hex() format and 36characters.
data = json.dumps({
  "sender": "ST113MYNN52BC76GWP8P9PYFEP7XWJP6S5YFQM4ZE",
  "arguments": [numbers[1]
  ]
})

url = 'https://stacks-node-api.testnet.stacks.co/v2/contracts/call-read/ST113MYNN52BC76GWP8P9PYFEP7XWJP6S5YFQM4ZE/db/get-map'

key = r.post(url, data=data, headers=headers).json()

hex_string = key['result'][2:]

bytes_object = bytes.fromhex(hex_string)
ascii_string = bytes_object.decode("ASCII")

print(key)
print(ascii_string)
