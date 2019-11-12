From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2019-10-07
Date: Tue, 12 Nov 2019 16:57:50 +0100
Message-ID: <0d53fe03-50a4-8a96-5605-7f20bd3c17fa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Tur0mlMzoEotqOZnqK6s9RQIuuTKrLGcB"
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>, Bastian Stender <bst@pengutronix.de>, Elenita Hinds <ecathinds@gmail.com>, Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>, Maxime Jayat <maxime.jayat@mobile-devices.fr>, Robin van der Gracht <robin@protonic.nl>, Oleksij Rempel <ore@pengutronix.de>, David Jander <david@protonic.nl>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tur0mlMzoEotqOZnqK6s9RQIuuTKrLGcB
Content-Type: multipart/mixed; boundary="zytl7yYg4fXNCkwHucDVISV29qWdpMEbc";
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
Message-ID: <0d53fe03-50a4-8a96-5605-7f20bd3c17fa@pengutronix.de>
Subject: pull-request: can-next 2019-10-07

--zytl7yYg4fXNCkwHucDVISV29qWdpMEbc
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 32 patches.

The first patch is by Gustavo A. R. Silva and removes unused code in the
generic CAN infrastructure.

The next three patches target the mcp251x driver. The one by Andy
Shevchenko removes the legacy platform data support from the driver. The
other two are by Timo Schl=C3=BC=C3=9Fler and reset the device only when =
needed,
to prevent glitches on the output when GPIO support is added.

I'm contributing two patches fixing checkpatch warnings in the
c_can_platform and peak_canfd driver.

Stephane Grosjean's patch for the peak_canfd driver adds hw timestamps
support in rx skbs.

The next three patches target the xilinx_can driver. One patch by me to
fix checkpatch warnings, one patch by Anssi Hannula to avoid non
requested bus error frames, and a patch by YueHaibing that switches the
driver to devm_platform_ioremap_resource().

Pankaj Sharma contributes two patches for the m_can driver, the first
one adds support for one shot mode, the other support for handling
arbitration errors.

Followed by four patches by YueHaibing, switching the grcan, ifi, rcar,
and sun4i drivers to devm_platform_ioremap_resource()

I'm contributing cleanup patches for the rx-offload helper, while Joakim
Zhang's patch prepares the rx-offload helper for CAN-FD support. The rx
offload users flexcan and ti_hecc are converted accordingly.

The remaining twelve patches target the flexcan driver. First Joakim
Zhang switches the driver to devm_platform_ioremap_resource(). The
remaining eleven patch are by me and clean up the abstract the access of
the iflag1 and iflag2 register both for RX and TX mailboxes. This is a
preparation for the upcoming CAN-FD support.

regards,
Marc

---

The following changes since commit 228200179213bfc9b4d6097e1c26de30bd18c1=
e6:

  Support LAN743x PTP periodic output on any GPIO (2019-11-11 12:46:56 -0=
800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git ta=
gs/linux-can-next-for-5.5-20191111

for you to fetch changes up to b9468ad8ff65e6dcfeb69cab15deecafdb883643:

  can: flexcan: flexcan_mailbox_read() make use of flexcan_write64() to m=
ark the mailbox as read (2019-11-11 21:58:12 +0100)

----------------------------------------------------------------
linux-can-next-for-5.5-20191111

----------------------------------------------------------------
Andy Shevchenko (1):
      can: mcp251x: get rid of legacy platform data

Anssi Hannula (1):
      can: xilinx_can: avoid non-requested bus error frames

Gustavo A. R. Silva (1):
      can: dev: can_restart(): remove unused code

Joakim Zhang (2):
      can: rx-offload: Prepare for CAN FD support
      can: flexcan: use devm_platform_ioremap_resource() to simplify code=


Marc Kleine-Budde (17):
      can: c_can: c_can_plaform: fix checkpatch warnings
      can: peak_canfd: fix checkpatch warnings
      can: xilinx_can: fix checkpatch warnings
      can: rx-offload: fix long lines
      can: rx-offload: can_rx_offload_compare(): fix typo
      can: rx-offload: can_rx_offload_irq_offload_timestamp(): don't use =
assignment in if condition
      can: rx-offload: can_rx_offload_reset(): remove no-op function
      can: flexcan: flexcan_irq_state(): only read timestamp if needed
      can: flexcan: rename macro FLEXCAN_IFLAG_MB() -> FLEXCAN_IFLAG2_MB(=
)
      can: flexcan: flexcan_irq(): rename variable reg_iflag -> reg_iflag=
_rx
      can: flexcan: rename struct flexcan_priv::reg_imask{1,2}_default to=
 rx_mask{1,2}
      can: flexcan: remove TX mailbox bit from struct flexcan_priv::rx_ma=
sk{1,2}
      can: flexcan: convert struct flexcan_priv::rx_mask{1,2} to rx_mask
      can: flexcan: introduce struct flexcan_priv::tx_mask and make use o=
f it
      can: flexcan: flexcan_read_reg_iflag_rx(): optimize reading
      can: flexcan: flexcan_irq(): add support for TX mailbox in iflag1
      can: flexcan: flexcan_mailbox_read() make use of flexcan_write64() =
to mark the mailbox as read

Pankaj Sharma (2):
      can: m_can: add support for one shot mode
      can: m_can: add support for handling arbitration error

Stephane Grosjean (1):
      can: peak_canfd: provide hw timestamps in rx skbs

Timo Schl=C3=BC=C3=9Fler (2):
      can: mcp251x: add mcp251x_write_2regs() and make use of it
      can: mcp251x: only reset hardware as required

YueHaibing (5):
      can: xilinx_can: use devm_platform_ioremap_resource() to simplify c=
ode
      can: grcan: use devm_platform_ioremap_resource() to simplify code
      can: ifi: use devm_platform_ioremap_resource() to simplify code
      can: rcar: use devm_platform_ioremap_resource() to simplify code
      can: sun4i: use devm_platform_ioremap_resource() to simplify code

 arch/arm/mach-pxa/icontrol.c                  |   9 +-
 arch/arm/mach-pxa/zeus.c                      |   9 +-
 drivers/net/can/c_can/c_can_platform.c        |  21 +++--
 drivers/net/can/dev.c                         |   5 +-
 drivers/net/can/flexcan.c                     | 131 +++++++++++++++-----=
------
 drivers/net/can/grcan.c                       |   4 +-
 drivers/net/can/ifi_canfd/ifi_canfd.c         |   4 +-
 drivers/net/can/m_can/m_can.c                 |  54 ++++++++++-
 drivers/net/can/peak_canfd/peak_canfd.c       |  25 +++--
 drivers/net/can/peak_canfd/peak_canfd_user.h  |   3 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c |   6 +-
 drivers/net/can/rcar/rcar_can.c               |   4 +-
 drivers/net/can/rcar/rcar_canfd.c             |   4 +-
 drivers/net/can/rx-offload.c                  | 122 +++++++++-----------=
----
 drivers/net/can/spi/mcp251x.c                 |  75 ++++++++++++---
 drivers/net/can/sun4i_can.c                   |   4 +-
 drivers/net/can/ti_hecc.c                     |  26 +++--
 drivers/net/can/xilinx_can.c                  | 102 ++++++++++----------=

 include/linux/can/platform/mcp251x.h          |  22 -----
 include/linux/can/rx-offload.h                |   7 +-
 20 files changed, 360 insertions(+), 277 deletions(-)
 delete mode 100644 include/linux/can/platform/mcp251x.h

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |-
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


















--zytl7yYg4fXNCkwHucDVISV29qWdpMEbc--

--Tur0mlMzoEotqOZnqK6s9RQIuuTKrLGcB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEmvEkXzgOfc881GuFWsYho5HknSAFAl3K1oEACgkQWsYho5Hk
nSAs9wf+NGgI/0VY+lv3kBV3GQgNm901+GcIWV8y889DJCDNBEoDON0xZPvD0va1
yARBIhEjWfifOUWiRmd6ch6V1eLq1MKkVnKzb+83kunpK4qcXTkb/6x+zEdeEnUI
C4AjJt20Cn944r7ZkXKjo+bPdyC+Q8/MECjF/mZzbrMzl13B2htQO7mnHhFvtakd
2JvaA7XHTRHXx9BnGzN0J+d9MAfkOUhs207CyggEQDXRHBGx0fPquivM4dM8V7Ie
4zMc32h1JwM7xQipdOhCKQVGeH5Ms5haTJvW2FJnH9MtC8mqqgW3+73nc1t2AGNv
Dkr7vOx+akKz6+2FGztcorQam66Jxw==
=xdN5
-----END PGP SIGNATURE-----

--Tur0mlMzoEotqOZnqK6s9RQIuuTKrLGcB--
