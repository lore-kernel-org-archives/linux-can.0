From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2017-12-01
Date: Fri, 1 Dec 2017 10:57:43 +0100
Message-ID: <b2a795da-bde5-0527-ff07-762d5485ce45@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HfrkL3JbrTGJJNj1txCKfHtP7U3PiT8O0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:48075 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751675AbdLAJ5w (ORCPT
        <rfc822;linux-can@vger.kernel.ORG>); Fri, 1 Dec 2017 04:57:52 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HfrkL3JbrTGJJNj1txCKfHtP7U3PiT8O0
Content-Type: multipart/mixed; boundary="0CWCmPbNApqBSi4nHhuMA9mnMKWTkEIAq";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: David Miller <davem@davemloft.net>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <b2a795da-bde5-0527-ff07-762d5485ce45@pengutronix.de>
Subject: pull-request: can-next 2017-12-01

--0CWCmPbNApqBSi4nHhuMA9mnMKWTkEIAq
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request of 10 patches for net-next/master.

The first two patches are by Arnd Bergmann, they convert the peak_usb
from using "struct timeval" to "ktime_t". The error handling in the
vxcan driver is clean up by Markus Elfring's patch. Bhumika Goyal
contributes a patch for the c_can_pci driver to make the pci data const.
The six patches by Pankaj Bansal for the flexcan driver add LS1021A
support by making the endianness of the driver configurable by the
device tree.

regards,
Marc

---

The following changes since commit 201c78e05c5adaffa163b022c9b3a4d30debe1=
00:

  Merge branch 'macb-rx-packet-filtering' (2017-11-30 14:12:47 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git ta=
gs/linux-can-next-for-4.17-20171201

for you to fetch changes up to fa2edcfb5f2e99e9f47f7ecba9abc5f192aa388b:

  arm: dts: Add nodes for flexcan devices present on LS1021A-Rev2 SoC (20=
17-12-01 09:14:23 +0100)

----------------------------------------------------------------
linux-can-next-for-4.17-20171201

----------------------------------------------------------------
Arnd Bergmann (2):
      can: peak_usb: remove some 'struct timeval' users
      can: peak_usb: use ktime_t consistently

Bhumika Goyal (1):
      can: c_can_pci: make c_can_pci_data const

Markus Elfring (1):
      can: vxcan: Use common error handling code in vxcan_newlink()

Pankaj Bansal (6):
      can: flexcan: Remodel FlexCAN register r/w APIs for big endian Flex=
CAN controllers.
      can: flexcan: adding platform specific details for LS1021A
      Documentation: can: flexcan: Add big-endian property to device tree=

      powerpc: dts: P1010: Add endianness property to flexcan node
      arm: dts: Remove p1010-flexcan compatible from imx series dts
      arm: dts: Add nodes for flexcan devices present on LS1021A-Rev2 SoC=


 .../devicetree/bindings/net/can/fsl-flexcan.txt    |   6 +
 arch/arm/boot/dts/imx25.dtsi                       |   4 +-
 arch/arm/boot/dts/imx28.dtsi                       |   4 +-
 arch/arm/boot/dts/imx35.dtsi                       |   4 +-
 arch/arm/boot/dts/imx53.dtsi                       |   4 +-
 arch/arm/boot/dts/ls1021a-qds.dts                  |  16 ++
 arch/arm/boot/dts/ls1021a-twr.dts                  |  16 ++
 arch/arm/boot/dts/ls1021a.dtsi                     |  36 +++
 arch/powerpc/boot/dts/fsl/p1010si-post.dtsi        |   2 +
 drivers/net/can/c_can/c_can_pci.c                  |   4 +-
 drivers/net/can/flexcan.c                          | 241 ++++++++++++---=
------
 drivers/net/can/usb/peak_usb/pcan_usb.c            |   9 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.c       |  53 ++---
 drivers/net/can/usb/peak_usb/pcan_usb_core.h       |   5 +-
 drivers/net/can/usb/peak_usb/pcan_usb_pro.c        |   9 +-
 drivers/net/can/vxcan.c                            |  16 +-
 16 files changed, 258 insertions(+), 171 deletions(-)

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--0CWCmPbNApqBSi4nHhuMA9mnMKWTkEIAq--

--HfrkL3JbrTGJJNj1txCKfHtP7U3PiT8O0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlohJ5cACgkQHv7KIOw4
HPY2YQf7Bbw30RyALKx1YOfwV22Nx982MBlESUZO6lH2WKu9bdby+pAtuEuCTT8b
o/lfs911OqrI2XwK8n4PZgdUoTDJHDd4f0luVysM0TxC2L7xe9TpSH1PkTL1jRQr
z6HC7HKTyoBghQ8I1hP8FmWFxwHimz6YMSO/ZOiePFAzO1kJgy9dnxz0jTlZOB5K
RLZ5Tf73APhMHZt0iuePYrt4IEnPkxfLfXf1nrD6IanJCrh27diQ/CHt6kDef+5B
lJ91oaoLxhCtOnvPdiJ66/mhq3nWEWdnWY3vzVDfOuSpLq6tKTeUXPwTrYL/fsat
erMXpiZG+eruOP/clhs2BXCWa0UmKQ==
=ofIL
-----END PGP SIGNATURE-----

--HfrkL3JbrTGJJNj1txCKfHtP7U3PiT8O0--
