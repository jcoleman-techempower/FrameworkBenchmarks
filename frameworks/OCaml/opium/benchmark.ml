open Opium.Std

let plaintext = get "/plaintext" begin fun req_ ->
  `String ("Hello, World!") |> respond`
end

let _ =
  App.empty
  |> plaintext
  |> App.run_command
