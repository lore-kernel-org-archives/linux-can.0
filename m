From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2019-09-04 j1939
Date: Wed, 4 Sep 2019 14:29:56 +0200
Message-ID: <d56029d4-2d4c-3cb3-0e5b-e28866db87f1@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="gxFURhHboClmdQqNh66DFNgv0T72J1UIn"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Bastian Stender <bst@pengutronix.de>, Elenita Hinds <ecathinds@gmail.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Maxime Jayat <maxime.jayat@mobile-devices.fr>, Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <ore@pengutronix.de>, David Jander <david@protonic.nl>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gxFURhHboClmdQqNh66DFNgv0T72J1UIn
Content-Type: multipart/mixed; boundary="7jhhL6AeQNjl7rWVrrLihX2llfScyTDCn";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org,
 Oliver Hartkopp <socketcan@hartkopp.net>,
 Bastian Stender <bst@pengutronix.de>, Elenita Hinds <ecathinds@gmail.com>,
 Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>,
 Maxime Jayat <maxime.jayat@mobile-devices.fr>,
 Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel
 <ore@pengutronix.de>, David Jander <david@protonic.nl>
Message-ID: <d56029d4-2d4c-3cb3-0e5b-e28866db87f1@pengutronix.de>
Subject: pull-request: can-next 2019-09-04 j1939

--7jhhL6AeQNjl7rWVrrLihX2llfScyTDCn
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 21 patches.

the first 12 patches are by me and target the CAN core infrastructure.
They clean up the names of variables , structs and struct members,
convert can_rx_register() to use max() instead of open coding it and
remove unneeded code from the can_pernet_exit() callback.

The next three patches are also by me and they introduce and make use of
the CAN midlayer private structure. It is used to hold protocol specific
per device data structures.

The next patch is by Oleksij Rempel, switches the
&net->can.rcvlists_lock from a spin_lock() to a spin_lock_bh(), so that
it can be used from NAPI (soft IRQ) context.

The next 4 patches are by Kurt Van Dijck, he first updates his email
address via mailmap and then extends sockaddr_can to include j1939
members.

The final patch is the collective effort of many entities (The j1939
authors: Oliver Hartkopp, Bastian Stender, Elenita Hinds, kbuild test
robot, Kurt Van Dijck, Maxime Jayat, Robin van der Gracht, Oleksij
Rempel, Marc Kleine-Budde). It adds support of SAE J1939 protocol to the
CAN networking stack.

SAE J1939 is the vehicle bus recommended practice used for communication
and diagnostics among vehicle components. Originating in the car and
heavy-duty truck industry in the United States, it is now widely used in
other parts of the world.

regards,
Marc

P.S.: This pull request doesn't invalidate my last pull request:
      "pull-request: can-next 2019-09-03".

---

The following changes since commit 2c1f9e26344483e2c74e80ef708d9c7fd2e543=
f4:

  Merge branch '100GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/=
jkirsher/next-queue (2019-09-03 21:51:25 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git ta=
gs/linux-can-next-for-5.4-20190904

for you to fetch changes up to 9d71dd0c70099914fcd063135da3c580865e924c:

  can: add support of SAE J1939 protocol (2019-09-04 14:22:33 +0200)

----------------------------------------------------------------
linux-can-next-for-5.4-20190904

----------------------------------------------------------------
Kurt Van Dijck (4):
      mailmap: update email address
      can: introduce CAN_REQUIRED_SIZE macro
      can: add socket type for CAN_J1939
      can: extend sockaddr_can to include j1939 members

Marc Kleine-Budde (15):
      can: netns: give structs holding the CAN statistics a sensible name=

      can: netns: give members of struct netns_can holding the statistics=
 a sensible name
      can: af_can: give variables holding CAN statistics a sensible name
      can: proc: give variables holding CAN statistics a sensible name
      can: netns: remove "can_" prefix from members struct netns_can
      can: af_can: give variable holding the CAN per device receive lists=
 a sensible name
      can: proc: give variable holding the CAN per device receive lists a=
 sensible name
      can: af_can: rename find_rcv_list() to can_rcv_list_find()
      can: af_can: rename find_dev_rcv_lists() to can_dev_rcv_lists_find(=
)
      can: af_can: give variable holding the CAN receiver and the receive=
r list a sensible name
      can: af_can: can_rx_register(): use max() instead of open coding it=

      can: af_can: can_pernet_exit(): no need to iterate over and cleanup=
 registered CAN devices
      can: introduce CAN midlayer private and allocate it automatically
      can: make use of preallocated can_ml_priv for per device struct can=
_dev_rcv_lists
      can: af_can: remove NULL-ptr checks from users of can_dev_rcv_lists=
_find()

Oleksij Rempel (1):
      can: af_can: use spin_lock_bh() for &net->can.rcvlists_lock

The j1939 authors (1):
      can: add support of SAE J1939 protocol

 .mailmap                           |    1 +
 Documentation/networking/index.rst |    1 +
 Documentation/networking/j1939.rst |  422 ++++++++
 MAINTAINERS                        |   10 +
 drivers/net/can/dev.c              |   24 +-
 drivers/net/can/slcan.c            |    6 +-
 drivers/net/can/vcan.c             |    7 +-
 drivers/net/can/vxcan.c            |    4 +-
 include/linux/can/can-ml.h         |   68 ++
 include/linux/can/core.h           |    8 +
 include/net/netns/can.h            |   14 +-
 include/uapi/linux/can.h           |   20 +-
 include/uapi/linux/can/j1939.h     |   99 ++
 net/can/Kconfig                    |    2 +
 net/can/Makefile                   |    2 +
 net/can/af_can.c                   |  302 +++---
 net/can/af_can.h                   |   19 +-
 net/can/bcm.c                      |    4 +-
 net/can/j1939/Kconfig              |   15 +
 net/can/j1939/Makefile             |   10 +
 net/can/j1939/address-claim.c      |  230 ++++
 net/can/j1939/bus.c                |  333 ++++++
 net/can/j1939/j1939-priv.h         |  338 ++++++
 net/can/j1939/main.c               |  403 +++++++
 net/can/j1939/socket.c             | 1160 +++++++++++++++++++++
 net/can/j1939/transport.c          | 2027 ++++++++++++++++++++++++++++++=
++++++
 net/can/proc.c                     |  163 +--
 net/can/raw.c                      |    4 +-
 28 files changed, 5398 insertions(+), 298 deletions(-)
 create mode 100644 Documentation/networking/j1939.rst
 create mode 100644 include/linux/can/can-ml.h
 create mode 100644 include/uapi/linux/can/j1939.h
 create mode 100644 net/can/j1939/Kconfig
 create mode 100644 net/can/j1939/Makefile
 create mode 100644 net/can/j1939/address-claim.c
 create mode 100644 net/can/j1939/bus.c
 create mode 100644 net/can/j1939/j1939-priv.h
 create mode 100644 net/can/j1939/main.c
 create mode 100644 net/can/j1939/socket.c
 create mode 100644 net/can/j1939/transport.c

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |-
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |














--7jhhL6AeQNjl7rWVrrLihX2llfScyTDCn--

--gxFURhHboClmdQqNh66DFNgv0T72J1UIn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl1vrkQACgkQWsYho5Hk
nSBcfwf+Lj+UN6ZZKihUPvDBcRvcC3awc2ad/h7wkYuWvNuMJ0o6OdDjWve+IujB
RD+VpaF68tOiDkKLiaPoLvTM3+/7y/p3yJTcl73FbVDskMZcpKMphLx9S0bOLmp1
PCsU1DUq8qXdHeD8zJutOTu/iIeJWWi5M8z5B39cz8LW5WuiglJHbGhwKoJjWBXz
fL7eNcxxD4UI48hOtGQEl11UYN3JfemCID8xKkuN001I6vnk0py9Rxl4xBZ6+30R
0r4qOTwzq12EJ/hmCjck8sxYvDiEws2zsN7NloBiBrTQJUtyJWVlp6BdA7Wk+CDF
M0O0jhUIpER/T0uIlQ1ubM29L8vUvQ==
=9kyu
-----END PGP SIGNATURE-----

--gxFURhHboClmdQqNh66DFNgv0T72J1UIn--
