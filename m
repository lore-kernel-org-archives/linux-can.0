From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: pull-request: can-next 2017-12-01
Date: Fri, 5 Jan 2018 12:08:35 +0100
Message-ID: <fa3b4f70-3f87-936a-4bbb-fdd0ef97a095@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WbnwRreGRk2cbuOnoebnLARR64sAj4RG5"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:44313 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751348AbeAELIy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 5 Jan 2018 06:08:54 -0500
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WbnwRreGRk2cbuOnoebnLARR64sAj4RG5
Content-Type: multipart/mixed; boundary="esS8f6HWZ2Em36HTzyEfSKbiVvMlkAk8z";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: David Miller <davem@davemloft.net>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <fa3b4f70-3f87-936a-4bbb-fdd0ef97a095@pengutronix.de>
Subject: pull-request: can-next 2017-12-01

--esS8f6HWZ2Em36HTzyEfSKbiVvMlkAk8z
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hello David,

this is a pull request of 7 patches for net-next/master.

All patches are by me. Patch 6 is for the "can_raw" protocol and add
error checking to the bind() function. All other patches clean up the
coding style and remove unused parameters in various CAN drivers and
infrastructure.

regards,
Marc

---

The following changes since commit 72deacce011bde7475c90e6ee7d4c7d28c3848=
73:

  Merge tag 'mac80211-next-for-davem-2018-01-04' of git://git.kernel.org/=
pub/scm/linux/kernel/git/jberg/mac80211-next (2018-01-04 14:33:29 -0500)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-ne=
xt.git tags/linux-can-next-for-4.16-20180105

for you to fetch changes up to ff847ee47be27621f978921919f035fcd87d6d08:

  can: af_can: give struct holding the CAN per device receive lists a sen=
sible name (2018-01-05 11:12:08 +0100)

----------------------------------------------------------------
linux-can-next-for-4.16-20180105

----------------------------------------------------------------
Marc Kleine-Budde (7):
      can: rx-offload: can_rx_offload_add_timestamp: remove duplicate sem=
icolon at return statement
      can: gs_usb: gs_cmd_reset(): remove unused parameter "struct gs_usb=
 *gsusb"
      can: mcp251x: mcp251x_setup(): remove unused parameter "struct mcp2=
51x_priv *priv"
      can: peak_usb: peak_usb_netif_rx(): remove unused parameter "u32 ts=
_high"
      can: slcan: slc_alloc(): remove unused parameter "dev_t line"
      can: raw: raw_bind(): bail out if can_family is not AF_CAN
      can: af_can: give struct holding the CAN per device receive lists a=
 sensible name

 drivers/net/can/rx-offload.c                 |  2 +-
 drivers/net/can/slcan.c                      |  4 ++--
 drivers/net/can/spi/mcp251x.c                |  7 +++----
 drivers/net/can/usb/gs_usb.c                 |  4 ++--
 drivers/net/can/usb/peak_usb/pcan_usb_core.c |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +-
 drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  9 +++------
 include/net/netns/can.h                      |  4 ++--
 net/can/af_can.c                             | 20 ++++++++++----------
 net/can/af_can.h                             |  2 +-
 net/can/proc.c                               |  8 ++++----
 net/can/raw.c                                |  2 ++
 12 files changed, 32 insertions(+), 34 deletions(-)

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--esS8f6HWZ2Em36HTzyEfSKbiVvMlkAk8z--

--WbnwRreGRk2cbuOnoebnLARR64sAj4RG5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpPXLMACgkQHv7KIOw4
HPZoxAf/b2gvotqT+O+mkfdSR6kXoVvHAbA0gTM5CIqZGmr7Qahx65WEIxMM83Uk
UH5K3E22W4UFGadXGNwCXDKJcQbsRlddDzc4s9PKqYlJ7YwXMYpz6Erdl2WMPw5t
lK9lJwRqjEOF4N9bY01vMFsUtNGOCjvX23FW1w0Eqr2C4AxYhuGfu086Lbme0+Ib
cqOb4HV6A8UoQVzSaPQn8uWF566ANyrNNnxrS/CEefqQVW24I1oK92QrurJ52D3V
GR8IYk9bIdh0RUmiXzTvRUZD4GzyvnPTya0Ag/M0gwG9xrbf+b4qJPgN3URcVukz
rjbMyHBc/xl/u4ZWj6jwtUZqLrfBnQ==
=zjsE
-----END PGP SIGNATURE-----

--WbnwRreGRk2cbuOnoebnLARR64sAj4RG5--
