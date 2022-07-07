import asyncio
import os

from pontis.admin.client import PontisAdminClient

publishers = ["pontis", "argent", "cmt"]  # , "equilibrium", "consensys"]
publisher_address = [
    int(os.environ.get("PUBLISHER_ADDRESS"), 0),
    0x05BD6A92D27E52BF969002B72F263616103E03DA91E8C605AA842BB27C51516C,
    0x03851e76297e6d57c4ff049b502262663d37abc373600eeba4f0f6888d5d38ab
]


async def main():
    admin_private_key = int(os.environ.get("ADMIN_PRIVATE_KEY"), 0)
    admin_client = PontisAdminClient(
        admin_private_key,
    )
    for publisher, address in zip(publishers, publisher_address):
        await admin_client.register_publisher_if_not_registered(publisher, address)


if __name__ == "__main__":

    asyncio.run(main())
