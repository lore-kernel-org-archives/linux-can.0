From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 3/3] can: af_can: fix sparse warning for can_rx_alldev_list
Date: Wed, 20 Jun 2012 10:00:10 +0200
Message-ID: <4FE1830A.3020605@pengutronix.de>
References: <1340136320-30840-1-git-send-email-mkl@pengutronix.de> <1340136320-30840-4-git-send-email-mkl@pengutronix.de> <4FE1460F.8040409@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3114D27A7280388944573D26"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52415 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755177Ab2FTIAN (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 20 Jun 2012 04:00:13 -0400
In-Reply-To: <4FE1460F.8040409@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3114D27A7280388944573D26
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/20/2012 05:39 AM, Oliver Hartkopp wrote:
> On 19.06.2012 22:05, Marc Kleine-Budde wrote:
>=20
>> Make can_rx_alldev_list static to fix the following sparse warning:
>> net/can/af_can.c:80:22: warning: symbol 'can_rx_alldev_list' was not
>> declared. Should it be static?
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  net/can/af_can.c |    2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/net/can/af_can.c b/net/can/af_can.c
>> index 821022a..ccef846 100644
>> --- a/net/can/af_can.c
>> +++ b/net/can/af_can.c
>> @@ -78,7 +78,7 @@ module_param(stats_timer, int, S_IRUGO);
>>  MODULE_PARM_DESC(stats_timer, "enable timer for statistics (default:o=
n)");
>> =20
>>  /* receive filters subscribed for 'all' CAN devices */
>> -struct dev_rcv_lists can_rx_alldev_list;
>> +static struct dev_rcv_lists can_rx_alldev_list;
>>  static DEFINE_SPINLOCK(can_rcvlists_lock);
>> =20
>>  static struct kmem_cache *rcv_cache __read_mostly;
>=20
>=20
> Hello Marc,
>=20
> did you already compile this?

Compile yes, link no :D

> can_rx_alldev_list is used in af_can.c and proc.c :
>=20
> $ grep can_rx_alldev_list *.c
> af_can.c:struct dev_rcv_lists can_rx_alldev_list;
> af_can.c:		return &can_rx_alldev_list;
> af_can.c:	matches =3D can_rcv_filter(&can_rx_alldev_list, skb);
> af_can.c:	memset(&can_rx_alldev_list, 0, sizeof(can_rx_alldev_list));
> proc.c:extern struct dev_rcv_lists can_rx_alldev_list;
         ^^^^^^

> proc.c:	d =3D &can_rx_alldev_list;
> proc.c:	d =3D &can_rx_alldev_list;
>=20
> So i wonder if making it static inside af_can.c is a good idea.
>=20
> Is there no way to satisfy the sparse warning in another way?

Yes, don't use extern, put it into af_can.h.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3114D27A7280388944573D26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/hgwoACgkQjTAFq1RaXHOUtACdHFWtw0ggcM7dX/Km77KusXvg
YooAn0PoB4AMsbGVjVluyQ25d5Tm3KPE
=u9ZK
-----END PGP SIGNATURE-----

--------------enig3114D27A7280388944573D26--
