ipaddr_extensions
=================

Adds the `ipaddr_extensions` gem to chef using the chef_gem provider. This adds a
top-level ohai attribute called `privateaddress`. If there is an RFC1918 IP address,
this is assigned to `node.privateaddress`.

## Usage

Include `ipaddr_extensions` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[ipaddr_extensions]"
  ]
}
```

If a cookbook depends on knowing about private ip addresses, depend or suggest this cookbook.

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github
