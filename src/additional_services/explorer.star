POSTGRES_IMAGE = "postgresql:14.6"
POSTGRES_SERVICE_NAME = "postgresql"
POSTGRES_API_PROTOCOL_NAME = "postgres"
POSTGRES_PORT_NAME = "postgresql"
POSTGRES_PORT_NUMBER = 5432

POSTGRES_DB = "postgres"
POSTGRES_USER = "postgres"
POSTGRES_PASSWORD = "postgres"

MADARA_EXPLORER_IMAGE = "sotazklabs/stark_compass_explorer:v0.2.38"
MADARA_EXPLORER_SERVICE_NAME = "madara_explorer"
MADARA_EXPLORER_API_PROTOCOL_NAME = "http"
MADARA_EXPLORER_PORT_NAME = "madara_explorer"
MADARA_EXPLORER_PORT_NUMBER = 4000

def create_postgres_service(plan):
    postgres_service_config = ServiceConfig(
        image = POSTGRES_IMAGE,
        ports = {
            POSTGRES_PORT_NAME: PortSpec(
                number = POSTGRES_PORT,
                application_protocol = POSTGRES_API_PROTOCOL_NAME
            ),
        },
        env_vars = {
            "POSTGRES_DB": POSTGRES_DB,
            "POSTGRES_USER": POSTGRES_USER,
            "POSTGRES_PASSWORD": POSTGRES_PASSWORD,
        },
        cmd = ["-N 1000"],
    )

    plan.add_service(
        name=POSTGRES_SERVICE_NAME,
        config=postgres_service_cfg,
        description="Starting Postgres Service",
    )

def create_explorer_service(plan, madara_url, postgres_url):
    madara_explorer_config = ServiceConfig(
        image = MADARA_EXPLORER_IMAGE,
        ports = {
            MADARA_EXPLORER_API_PROTOCOL_NAME: PortSpec(
                number = MADARA_EXPLORER_PORT_NUMBER,
                application_protocol = MADARA_EXPLORER_API_PROTOCOL_NAME,
            ),
        },
        env_vars = {
            "DB_TYPE" = "postgresql",
            "DISABLE_MAINNET_SYNC" = true,
            "DISABLE_SEPOLIA_SYNC" = false,
            "RPC_API_HOST" = madara_url,
            "SEPOLIA_RPC_API_HOST" = madara_url,
            "SECRET_KEY_BASE" = "JyULoT5cLBifW+XNEuCTVoAb+SaFgQt9j227RN0cKpR3wTsrApGd1HNcgeopemyl",
            "DATABASE_URL" = postgres_url,
            "PHX_HOST" = "10.20.10.121",
            "PORT" = 4000,
        }
    )

    plan.add_service(
        name = MADARA_EXPLORER_SERVICE_NAME,
        config = madara_explorer_config,
        description = "Starting Madara Explorer Service",
    )