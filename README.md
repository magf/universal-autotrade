# Universal Autotrade

Universal Autotrade is a Go-based trading system designed to collect market data from cryptocurrency exchanges, process trading signals using modular indicators, and execute automated trades. The system is packaged as a DEB package for easy deployment on Debian/Ubuntu systems.

## Features
- Collects real-time market data (e.g., trades, order book) for specified trading pairs.
- Processes trading signals using a modular indicator system (e.g., market temperature, MA crossover, RSI).
- Executes trades based on a configurable strategy engine.
- Stores data in a SQLite database for analysis and backtesting.
- Supports multiple trading pairs via systemd template services (`universal-autotrade@<pair>.service`).
- Includes automated setup via DEB package installation scripts.

## Prerequisites
- Go 1.18 or later (for building from source).
- Debian/Ubuntu system for DEB package installation.
- `sqlite3` for querying the database.
- `dpkg` for building and installing the DEB package.
- Internet access to connect to exchange APIs.

## Installation

### Building from Source

1. Clone the repository:
   ```bash
   git clone https://github.com/magf/universal-autotrade.git
   cd universal-autotrade
   ```
2. Initialize Go modules and fetch dependencies:
   ```bash
   go mod init universal-autotrade
   go get github.com/gorilla/websocket
   go get github.com/mattn/go-sqlite3
   ```
3. Build the binary:
   ```bash
   make build
   ```

### Building DEB Package

1. Ensure `dpkg-deb` is installed:
   ```bash
   sudo apt install dpkg
   ```
2. Build the DEB package:
   ```bash
   make deb
   ```
3. Install the DEB package:
   ```bash
   sudo dpkg -i universal-autotrade.deb
   ```

   The installation process will:
   - Create the `autotrade` system user.
   - Set up the `/var/lib/universal-autotrade` directory with appropriate permissions.
   - Install the systemd template service.
   - Automatically enable and start the `universal-autotrade@BTCUSDT` service.

### Running the Service

1. Start a service instance for a specific trading pair (e.g., `ETHUSDT`):
   ```bash
   sudo systemctl start universal-autotrade@ETHUSDT
   sudo systemctl enable universal-autotrade@ETHUSDT
   ```
2. Check the service status:
   ```bash
   sudo systemctl status universal-autotrade@ETHUSDT
   ```
3. View collected data:
   ```bash
   sqlite3 /var/lib/universal-autotrade/trades.db "SELECT * FROM trades LIMIT 10;"
   ```

## Usage

- Run manually for testing:
  ```bash
   ./universal-autotrade -pair=BTCUSDT -exchange=bitget
   ```
- Use `make run` to run with default settings:
   ```bash
   make run
   ```
- Data is stored in `/var/lib/universal-autotrade/trades.db`.

## Project Structure

```
universal-autotrade/
├── cmd/
│   └── universal-autotrade/  # Application entry point
├── pkg/
│   ├── exchange/            # Exchange API integration
│   ├── indicators/          # Trading indicators
│   ├── strategy/            # Trading strategy engine
│   ├── order/               # Order management
│   ├── auth/                # Authentication and API keys
│   └── db/                  # Database integration
├── debian/                  # DEB package configuration
├── scripts/                 # Build scripts
├── LICENSE                  # MIT License
├── README.md                # English documentation
├── Makefile                 # Build automation
├── go.mod                   # Go module dependencies
└── .gitignore               # Git ignore rules
```

## Contributing

Contributions are welcome! Please submit issues or pull requests to the repository. Ensure any changes are tested and follow the project's coding style.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

Maxim Gajdaj <maxim.gajdaj@gmail.com>
