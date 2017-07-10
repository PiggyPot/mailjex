# Mailjex

Elixir wrapper for the MailJet API.

## Installation

1. Add `mailjex` to your list of dependencies in mix.exs:

```elixir
def deps do
  [{:mailjex, "~> 0.1.0"}]
end
```

then...

```elixir
mix deps.get
```


2. Ensure `mailjex` is started before your application:

```elixir
def application do
  [applications: [:mailjex]]
end
```

3. Add configuration to your app:

```elixir
config :mailjex,
  api_base: "https://api.mailjet.com/v3",
  public_api_key: "<your public key>",
  private_api_key: "<your private key>"
```

4. Example usage:

```elixir
iex> body = %{
...>   "FromEmail": "fromemail@gmail.com",
...>   "FromName": "Mailjet Pilot",
...>   "Subject": "Your email flight plan!",
...>   "MJ-TemplateID": "999902",
...>   "MJ-TemplateLanguage": true,
...>   "Vars": %{"name": "Alice"},
...>   "Recipients": [%{"Email": "toemail@gmail.com"}]
...> }
iex> Mailjex.Delivery.send(body)
```

## For more information, see the Hex docs

You can read the docs [here](https://hexdocs.pm/mailjex)

## Development Setup

If you are making changes to this codebase and want to test your code, you will need to copy the sample secret file.

```elixir
cp config/secret.sample.exs config/secret.exs
```

Then add your MailJet public and private keys.

## Implementation state

Resources that are implemented so far.

- [x] Delivery (sending emails)
- [x] Messages
- [x] Template
- [ ] Sender Templates and Domains
- [ ] Contact Lists
- [ ] Contact Properties
- [ ] Campaigns
- [ ] Statistics
- [ ] Parse API
- [ ] Event API
- [ ] Account Settings
- [ ] System

Areas of the codebase that can be improved.

- [ ] Testing error cases