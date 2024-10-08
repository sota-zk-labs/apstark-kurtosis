MADARA_IMAGE = "sotazklabs/madara:latest"
MADARA_SERVICE_NAME = "madara"
MADARA_API_PROTOCOL_NAME = "http"
MADARA_PORT_NAME = "madara"
MADARA_PORT_NUMBER = 9944

def run(plan, suffix):
    madara = plan.add_service(
        name = MADARA_SERVICE_NAME + suffix,
        config = ServiceConfig(
            image = MADARA_IMAGE,
            ports = {
                MADARA_PORT_NAME: PortSpec(
                    number = MADARA_PORT_NUMBER,
                    application_protocol = MADARA_API_PROTOCOL_NAME,
                ),
            },
            cmd = [
                 "--name",
                 "madara",
                 "--base-path",
                 "../madara_db",
                 "--devnet",
                 "--telemetry-disabled",
                 "--rpc-port",
                 "9944",
                 "--rpc-cors=all",
                 "--rpc-external",
                 "--no-l1-sync",
                 "--rpc-methods",
                 "unsafe"
            ]
        )
    )
