# basic

## install

### uninstall

```bash
#remove installed package
go clean -i ${package import path}
```

## usage

need to proxy `source.google.com` when use `go get`

## spec

package level statements always start with **keywords**.

| notation   | desc                                       |
| ---------- | ------------------------------------------ |
| `T(v)`     | type conversion                            |
| `[n]T`     | array def                                  |
| `*T`       | type pointer definition                    |
| `*p`       | ref to pointer value                       |
| `p.x`      | equal to `(*p).x` if p is struct pointer   |

```go
primes := [6]int{2, 3, 5, 7, 11, 13}
```
# OOP

## Interface

func (param Interface) can only accept pointers as input.
