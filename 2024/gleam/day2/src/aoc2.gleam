import gleam/io
import gleam/list
import gleam/string

pub fn main() {
  let input =
    "7 6 4 2 1
1 2 7 8 9
9 7 6 2 1
1 3 2 4 5
8 6 4 4 1
1 3 6 7 9
    "

  let text =
    input
    |> string.trim
    |> string.split("\n")
    |> list.map(fn(x) { string.split(x, " ") })
    |> list.fold()
    |> io.debug
}
