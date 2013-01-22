From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: upcoming pull reqeust
Date: Tue, 22 Jan 2013 23:03:08 +0100
Message-ID: <50FF0C9C.3030207@pengutronix.de>
References: <50F5C2EA.8030304@pengutronix.de> <50FAA0CF.8000007@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2KUJJAMLQSQDMNCRAJSKV"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39387 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837Ab3AVWDL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 22 Jan 2013 17:03:11 -0500
In-Reply-To: <50FAA0CF.8000007@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2KUJJAMLQSQDMNCRAJSKV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/19/2013 02:34 PM, Oliver Hartkopp wrote:
> Can you add my patchset
>=20
> "CAN sk_buff and can-gw enhancements"
>=20
> and Bernds
>=20
> "[PATCH v11] usb_8dev: Add support for USB2CAN interface from 8 devices=
"
>=20
> and the omitted LED support for the usb_8dev driver from Fabio too?

Done.

The patches are in the for-davem branch in the linux-can-next repo at
gitorious:

https://gitorious.org/linux-can/linux-can-next/commits/for-davem

Bernd Krumboeck (2):
      can: usb_8dev: Add support for USB2CAN interface from 8 devices
      can: usb_8dev: add LED trigger support

Fabio Baltieri (7):
      can: add tx/rx LED trigger support
      can: flexcan: add LED trigger support
      can: at91_can: add LED trigger support
      can: ti_hecc: add LED trigger support
      can: c_can: add LED trigger support
      can: mcp251x: add LED trigger support
      can: sja1000: add LED trigger support

Kurt Van Dijck (2):
      can: export a safe netdev_priv wrapper for candev
      can: rename LED trigger name on netdev renames

Marc Kleine-Budde (4):
      can: Kconfig: convert 'depends on CAN' into 'if CAN...endif' block
      can: Kconfig: convert 'depends on CAN_DEV' into 'if CAN_DEV...endif=
' block
      can: Kconfig: switch on all CAN protocolls by default
      can: sja1000: correct indention of Kconfig help text

Oliver Hartkopp (4):
      can: add private data space for CAN sk_buffs
      can: gw: make routing to the incoming CAN interface configurable
      can: gw: add a variable limit for CAN frame routings
      can: gw: indicate and count deleted frames due to misconfiguration

 drivers/net/can/Kconfig           |   37 +-
 drivers/net/can/Makefile          |    2 +
 drivers/net/can/at91_can.c        |   10 +
 drivers/net/can/c_can/Kconfig     |    2 +-
 drivers/net/can/c_can/c_can.c     |   10 +
 drivers/net/can/cc770/Kconfig     |    2 +-
 drivers/net/can/dev.c             |   26 +-
 drivers/net/can/flexcan.c         |   11 +
 drivers/net/can/led.c             |  124 +++++
 drivers/net/can/mcp251x.c         |   23 +-
 drivers/net/can/mscan/Kconfig     |    2 +-
 drivers/net/can/sja1000/Kconfig   |   14 +-
 drivers/net/can/sja1000/sja1000.c |   17 +-
 drivers/net/can/slcan.c           |    8 +-
 drivers/net/can/softing/Kconfig   |    2 +-
 drivers/net/can/ti_hecc.c         |   10 +
 drivers/net/can/usb/Kconfig       |    8 +-
 drivers/net/can/usb/Makefile      |    1 +
 drivers/net/can/usb/usb_8dev.c    | 1033 +++++++++++++++++++++++++++++++=
++++++
 include/linux/can/dev.h           |   11 +
 include/linux/can/led.h           |   51 ++
 include/linux/can/skb.h           |   35 ++
 include/uapi/linux/can/gw.h       |    2 +
 net/can/Kconfig                   |   13 +-
 net/can/bcm.c                     |   12 +-
 net/can/gw.c                      |   74 ++-
 net/can/raw.c                     |    8 +-
 27 files changed, 1488 insertions(+), 60 deletions(-)
 create mode 100644 drivers/net/can/led.c
 create mode 100644 drivers/net/can/usb/usb_8dev.c
 create mode 100644 include/linux/can/led.h
 create mode 100644 include/linux/can/skb.h

Comments?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2KUJJAMLQSQDMNCRAJSKV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlD/DJwACgkQjTAFq1RaXHP+kgCffMPPR0F/XCs6d8T36wwCcWMv
stgAoJg8byjSsRvxMB1vpVA0gy5SWjfe
=lZt9
-----END PGP SIGNATURE-----

------enig2KUJJAMLQSQDMNCRAJSKV--
