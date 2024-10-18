def apply_default(args):
    return {
        "name": "",
        "image": "",
        "port": "",
    } | args


def run(plan, args, suffix):
    args = apply_default(args)
    ports = {}
    ports["http"] = PortSpec(
        number=args["number"], application_protocol="http", wait=None
    )

    name = args["name"] + suffix

    config = ServiceConfig(
        image=args["image"],
        ports=ports,
        env_vars={
            "DEFAULT_REGION": "us-east-1",
            "AWS_ACCESS_KEY_ID": "AWS_ACCESS_KEY_ID",
            "AWS_SECRET_ACCESS_KEY": "AWS_SECRET_ACCESS_KEY",
        },
    )

    plan.add_service(name=name, config=config, description="Start Localstack Service")
