# SecretsKit

Encrypt and decrypt secrets in Vapor 4

### Basics

Encrypting data securely is a process that needs to be done "just right". By any deviation you will be degrading the strength of your encryption so please follow the steps described below to the point.

### Use

#### Generating random data

Use included `RandomGenerator` app to generate an array of trully randomised bytes. You can of course generate your own sequence, just make sure the data is 32 bytes long, has not been generated from a string (strings are much simpler then random Data generated using `URandom`) and the whole thing is `base64` encoded.

You can install `random-generator` utility via `brew`

```bash
brew tap einstore/homebrew-tap
brew install random-generator
```

If you run `RandomGenerator` from this package, it should output what you need right away.

> In `Debug` mode, when no `SECRET` is set a default value will be used. This functionality will break if you switch to `Production`!

#### Set the environment variable

By default the library will be looking for `SECRET` environmental variable. You can change the name of the variable before the library is used for the first time (probably in your `configure` method) by modifying the `Secrets.envVarName` static property.

#### Encrypt/decrypt string

> There is more ways to use the library, below are just basic examples

```swift
let string = "hello"
let secret = try Secrets.encrypt(string)
let result = try Secrets.decrypt(string: secret)

// or

let string = "hello"
let secret = try Secrets.encrypt(asData: string)
let result = try Secrets.decrypt(string: secret)
```

#### Encrypt/decrypt data

```swift
let data = "hello".data(using: .utf8)!
let secret = try Secrets.encrypt(data)
let result = try Secrets.decrypt(data: secret)
```

### Author

Ondrej Rafaj - @rafiki270


### License

Licensed under MIT; Copyright Einstore 2019
