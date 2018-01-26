From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2018-01-26
Date: Fri, 26 Jan 2018 11:01:41 +0100
Message-ID: <f76dc058-dcbb-fdd7-1ad1-b46871c1ec0d@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="VZzlihVJzVDeylUxaLxXpTXvMQ1yijfZu"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50495 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752982AbeAZKCP (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 26 Jan 2018 05:02:15 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VZzlihVJzVDeylUxaLxXpTXvMQ1yijfZu
Content-Type: multipart/mixed; boundary="jVJiuOalO2NywwtPijPWKaqsJL10FKZxN";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kernel@pengutronix.de, linux-can@vger.kernel.org
Message-ID: <f76dc058-dcbb-fdd7-1ad1-b46871c1ec0d@pengutronix.de>
Subject: pull-request: can-next 2018-01-26

--jVJiuOalO2NywwtPijPWKaqsJL10FKZxN
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request for net-next/master consisting of 3 patches.

The first two patches target the CAN documentation. The first is by me
and fixes pointer to location of fsl,mpc5200-mscan node in the mpc5200
documentation. The second patch is by Robert Schwebel and it converts
the plain ASCII documentation to restructured text.

The third patch is by Fabrizio Castro add the r8a774[35] support to the
rcar_can dt-bindings documentation.

regards,
Marc

---

The following changes since commit 9515a2e082f91457db0ecff4b65371d0fb5d9a=
ad:

  net/ipv4: Allow send to local broadcast from a socket bound to a VRF (2=
018-01-25 21:51:31 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-ne=
xt.git tags/linux-can-next-for-4.16-20180126

for you to fetch changes up to 216bf2f490c214b8a0702b52cc957138ba24bc3f:

  dt-bindings: can: rcar_can: document r8a774[35] can support (2018-01-26=
 10:47:17 +0100)

----------------------------------------------------------------
linux-can-next-for-4.16-20180126

----------------------------------------------------------------
Fabrizio Castro (1):
      dt-bindings: can: rcar_can: document r8a774[35] can support

Marc Kleine-Budde (1):
      Documentation/devicetree: mpc5200.txt: fix pointer to location of f=
sl,mpc5200-mscan node

Robert Schwebel (1):
      can: migrate documentation to restructured text

 .../devicetree/bindings/net/can/rcar_can.txt       |    7 +-
 .../devicetree/bindings/powerpc/fsl/mpc5200.txt    |    2 +-
 Documentation/networking/00-INDEX                  |    2 -
 Documentation/networking/can.rst                   | 1437 ++++++++++++++=
++++++
 Documentation/networking/can.txt                   | 1308 --------------=
----
 Documentation/networking/index.rst                 |    1 +
 MAINTAINERS                                        |    2 +-
 drivers/net/can/dev.c                              |    2 +-
 drivers/net/can/vcan.c                             |    2 +-
 net/can/Kconfig                                    |    2 +-
 10 files changed, 1448 insertions(+), 1317 deletions(-)
 create mode 100644 Documentation/networking/can.rst
 delete mode 100644 Documentation/networking/can.txt

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--jVJiuOalO2NywwtPijPWKaqsJL10FKZxN--

--VZzlihVJzVDeylUxaLxXpTXvMQ1yijfZu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpq/IUACgkQHv7KIOw4
HPZdZggAh3OrFDASiJp3o+eP2gpBvRAyna8NtOAsv9fE2pjcOWb1HfcYOev1Mt7S
HVdSX/o8BEP9rOa5gGlwnH81NK7K2Sc98ZFivbvsqVJvX9OQUHP6PA6G6milnErd
jwYrt6qAwSMqhHnWmkQJAt3iMy/mANGxE2ogOXiz+8w8v0W9oiD6O8917xJfQfMv
l7Rs/pLsbmRjfCMspzmPu10UvFuSd98NupDmUKhLC7msyVVg8HfSOmiSg+hKmfAH
clJ+DNBxwxoMNiBMse6md4rcAFu4sVBs7oABUZi6aDuRNOOKxoGgSE4BHW0uFtDu
Eu7lqHeeJa+OH+EPOrNss05PcG7cnw==
=1tIW
-----END PGP SIGNATURE-----

--VZzlihVJzVDeylUxaLxXpTXvMQ1yijfZu--
