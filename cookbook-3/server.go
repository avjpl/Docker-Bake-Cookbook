package main

import (
    "fmt"
    "runtime"
    "time"
)

func main() {
    fmt.Printf("GO HTTP Server\n")
    fmt.Printf("Architecture: %s\n", runtime.GOARCH)
    fmt.Printf("OS: %s\n", runtime.GOOS)
    fmt.Printf("Started at: %s\n", time.Now().Format(time.RFC3339))

    // Keep the server alive
    select {}
}
