From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2019-10-07
Date: Mon, 7 Oct 2019 16:38:14 +0200
Message-ID: <2ffa00e7-d447-9216-587d-30396a47ca64@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="G2zGIErEkGqwCcMiesMRCS1O5a2VRBjRB"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Bastian Stender <bst@pengutronix.de>, Elenita Hinds <ecathinds@gmail.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Maxime Jayat <maxime.jayat@mobile-devices.fr>, Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <ore@pengutronix.de>, David Jander <david@protonic.nl>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G2zGIErEkGqwCcMiesMRCS1O5a2VRBjRB
Content-Type: multipart/mixed; boundary="UQ2pdH5nZsxFmUghxOUXTaFmFt77m1Lgr";
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
Message-ID: <2ffa00e7-d447-9216-587d-30396a47ca64@pengutronix.de>
Subject: pull-request: can-next 2019-10-07

--UQ2pdH5nZsxFmUghxOUXTaFmFt77m1Lgr
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 12 patches.

The first patch is by Andy Shevchenko for the mcp251x driver and removes
the legacy platform data from all in-tree users and the driver.

The next two patches target the peak_canfd driver, the first one is by
me and fixes several checkpatch warnings, the second one is by Stephane
Grosjean and adds hardware timestamps to the rx skbs.

Followed by two patches for the xilinx_can driver. Again the first is by
me and fixes checkpatch warnings, the second one is by Anssi Hannula and
avoids non-requested bus error frames, which improves performance.

Pankaj Sharma's patch for the m_can driver adds support for the one shot
mode.

YueHaibing provides a patch for the grcan driver to use
devm_platform_ioremap_resource() to simplify code.

Joakim Zhang provides a similar patch for the flexcan driver.

The last 4 patches are by me and target the rx-offload infrastructure.
The first 3 fix checkpatch warnings, the last one removes a no-op
function.

regards,
Marc

---

The following changes since commit 056ddc38e94105a7ee982ca06cc19448fc927f=
6f:

  Merge branch 'stmmac-next' (2019-10-06 18:46:31 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git ta=
gs/linux-can-next-for-5.5-20191007

for you to fetch changes up to f6008d6897270b492ec1b0a21814f9a99a113b17:

  can: rx-offload: can_rx_offload_reset(): remove no-op function (2019-10=
-07 16:34:39 +0200)

----------------------------------------------------------------
linux-can-next-for-5.5-20191007

----------------------------------------------------------------
Andy Shevchenko (1):
      can: mcp251x: Get rid of legacy platform data

Anssi Hannula (1):
      can: xilinx_can: avoid non-requested bus error frames

Joakim Zhang (1):
      can: flexcan: use devm_platform_ioremap_resource() to simplify code=


Marc Kleine-Budde (6):
      can: peak_canfd: fix checkpatch warnings
      can: xilinx_can: fix checkpatch warnings
      can: rx-offload: fix long lines
      can: rx-offload: can_rx_offload_compare(): fix typo
      can: rx-offload: can_rx_offload_irq_offload_timestamp(): don't use =
assignment in if condition
      can: rx-offload: can_rx_offload_reset(): remove no-op function

Pankaj Sharma (1):
      can: m_can: add support for one shot mode

Stephane Grosjean (1):
      can: peak_canfd: provide hw timestamps in rx skbs

YueHaibing (1):
      can: grcan: use devm_platform_ioremap_resource() to simplify code

 arch/arm/mach-pxa/icontrol.c                  |  9 +--
 arch/arm/mach-pxa/zeus.c                      |  9 +--
 drivers/net/can/flexcan.c                     |  4 +-
 drivers/net/can/grcan.c                       |  4 +-
 drivers/net/can/m_can/m_can.c                 | 12 +++-
 drivers/net/can/peak_canfd/peak_canfd.c       | 25 +++++--
 drivers/net/can/peak_canfd/peak_canfd_user.h  |  3 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c |  6 +-
 drivers/net/can/rx-offload.c                  | 55 ++++++++-------
 drivers/net/can/spi/mcp251x.c                 |  9 ++-
 drivers/net/can/xilinx_can.c                  | 98 ++++++++++++++-------=
------
 include/linux/can/platform/mcp251x.h          | 22 ------
 include/linux/can/rx-offload.h                |  1 -
 13 files changed, 131 insertions(+), 126 deletions(-)
 delete mode 100644 include/linux/can/platform/mcp251x.h

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |-
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
















--UQ2pdH5nZsxFmUghxOUXTaFmFt77m1Lgr--

--G2zGIErEkGqwCcMiesMRCS1O5a2VRBjRB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl2bTdYACgkQWsYho5Hk
nSDSewf8CiX6VmyRk3LllGGOB+tpb6CSj4XYfGVvVIbSNz8d0r6atMNMEVRHnJS7
P5CJ1qH+DSzz8POkEvyrjttmaKRsSLe5wCGhKUssErd7OEloB47jhL/GdSbgz7vy
nGo1WTht3avdIJfjlV7g5oTlXBCk8EVxCaGCgIpWfn6S9NfeCpZ0eAegWH+vjGTv
kLzpJd519cD4j0yCMyKWl+SyfaUBHQJyr07x1xUH9W6jyj0vhMj5wIOuRgjKfhBP
tL0LZ170I+eRMqMNkP4MpXgfCuY2ndw4X7mxNYtbPAfjAooHUF0Vkcg/OLua0BZ+
+GxaIeCwHTo2HwjBiDlBvkU0Qd5Azg==
=HN/L
-----END PGP SIGNATURE-----

--G2zGIErEkGqwCcMiesMRCS1O5a2VRBjRB--
