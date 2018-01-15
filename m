From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: pull-request: can-next 2017-12-01
Date: Mon, 15 Jan 2018 14:02:23 +0100
Message-ID: <be945e20-d5d5-f786-c9d4-3a3ef97a0292@pengutronix.de>
References: <fa3b4f70-3f87-936a-4bbb-fdd0ef97a095@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="hqhGpcBVMxM5OBtyj5TrHv8x6teX1SgWF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:32975 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967261AbeAONCs (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 15 Jan 2018 08:02:48 -0500
In-Reply-To: <fa3b4f70-3f87-936a-4bbb-fdd0ef97a095@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: netdev@vger.kernel.org
Cc: David Miller <davem@davemloft.net>, "kernel@pengutronix.de" <kernel@pengutronix.de>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hqhGpcBVMxM5OBtyj5TrHv8x6teX1SgWF
Content-Type: multipart/mixed; boundary="WOG7jrIcVpfiaUGmwuG8PovDr8T1gziDq";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: David Miller <davem@davemloft.net>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Message-ID: <be945e20-d5d5-f786-c9d4-3a3ef97a0292@pengutronix.de>
Subject: Re: pull-request: can-next 2017-12-01
References: <fa3b4f70-3f87-936a-4bbb-fdd0ef97a095@pengutronix.de>
In-Reply-To: <fa3b4f70-3f87-936a-4bbb-fdd0ef97a095@pengutronix.de>

--WOG7jrIcVpfiaUGmwuG8PovDr8T1gziDq
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Hello David,


On 01/05/2018 12:08 PM, Marc Kleine-Budde wrote:
> Hello David,
>=20
> this is a pull request of 7 patches for net-next/master.
>=20
> All patches are by me. Patch 6 is for the "can_raw" protocol and add
> error checking to the bind() function. All other patches clean up the
> coding style and remove unused parameters in various CAN drivers and
> infrastructure.

this pull request is still open. Any objections to pull this?

regards,
Marc

> ---
>=20
> The following changes since commit 72deacce011bde7475c90e6ee7d4c7d28c38=
4873:
>=20
>   Merge tag 'mac80211-next-for-davem-2018-01-04' of git://git.kernel.or=
g/pub/scm/linux/kernel/git/jberg/mac80211-next (2018-01-04 14:33:29 -0500=
)
>=20
> are available in the Git repository at:
>=20
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-=
next.git tags/linux-can-next-for-4.16-20180105
>=20
> for you to fetch changes up to ff847ee47be27621f978921919f035fcd87d6d08=
:
>=20
>   can: af_can: give struct holding the CAN per device receive lists a s=
ensible name (2018-01-05 11:12:08 +0100)
>=20
> ----------------------------------------------------------------
> linux-can-next-for-4.16-20180105
>=20
> ----------------------------------------------------------------
> Marc Kleine-Budde (7):
>       can: rx-offload: can_rx_offload_add_timestamp: remove duplicate s=
emicolon at return statement
>       can: gs_usb: gs_cmd_reset(): remove unused parameter "struct gs_u=
sb *gsusb"
>       can: mcp251x: mcp251x_setup(): remove unused parameter "struct mc=
p251x_priv *priv"
>       can: peak_usb: peak_usb_netif_rx(): remove unused parameter "u32 =
ts_high"
>       can: slcan: slc_alloc(): remove unused parameter "dev_t line"
>       can: raw: raw_bind(): bail out if can_family is not AF_CAN
>       can: af_can: give struct holding the CAN per device receive lists=
 a sensible name
>=20
>  drivers/net/can/rx-offload.c                 |  2 +-
>  drivers/net/can/slcan.c                      |  4 ++--
>  drivers/net/can/spi/mcp251x.c                |  7 +++----
>  drivers/net/can/usb/gs_usb.c                 |  4 ++--
>  drivers/net/can/usb/peak_usb/pcan_usb_core.c |  2 +-
>  drivers/net/can/usb/peak_usb/pcan_usb_core.h |  2 +-
>  drivers/net/can/usb/peak_usb/pcan_usb_fd.c   |  9 +++------
>  include/net/netns/can.h                      |  4 ++--
>  net/can/af_can.c                             | 20 ++++++++++----------=

>  net/can/af_can.h                             |  2 +-
>  net/can/proc.c                               |  8 ++++----
>  net/can/raw.c                                |  2 ++
>  12 files changed, 32 insertions(+), 34 deletions(-)
>=20


--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--WOG7jrIcVpfiaUGmwuG8PovDr8T1gziDq--

--hqhGpcBVMxM5OBtyj5TrHv8x6teX1SgWF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlpcpl8ACgkQHv7KIOw4
HPbrCAf/ab1+nzgNvLiDbyK43LXJ9qDiJsk2olYDjRuhBURF2a5e9cmt+Qi9uT0z
pzq+YT+61w20/CsOB5ylM1Rc0CSPEgD/eVebZpCy+XGT2/7t2SE/naBo5FYxvnSd
XwTyhPkkr5qtF+xX0Mqorn2xqaWWWNeWWFDYciDCffFYmGQZ7TbVUwz8U/niDzVh
cG6SF4Hbojp/VmBmBWcqCoxsTicvmiwFMhwxstsdxqLInn3qNzbrGjfU9274cS9X
uLZp6lpOa/70wSxPW0X8T8HabfSnrLiEuiaFpjC7A9en1vuJoxEl+zchSJPcN9x2
+DY8oI7+tVO9PbPJnTP1zgbs3B81xg==
=sZDD
-----END PGP SIGNATURE-----

--hqhGpcBVMxM5OBtyj5TrHv8x6teX1SgWF--
