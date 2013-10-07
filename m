From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5/7] can: dev: add berr_limit infrastrucutre
Date: Mon, 07 Oct 2013 18:00:45 +0200
Message-ID: <5252DAAD.1020009@pengutronix.de>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de> <1381156840-24071-6-git-send-email-mkl@pengutronix.de> <1876232.tLyIP8q8GR@ws-stein> <5252D9BE.9040905@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="n6VL6nakFs4oJQXa643w1fDak3Xi9j6jw"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49627 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab3JGQAu (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Oct 2013 12:00:50 -0400
In-Reply-To: <5252D9BE.9040905@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n6VL6nakFs4oJQXa643w1fDak3Xi9j6jw
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/07/2013 05:56 PM, Marc Kleine-Budde wrote:
> On 10/07/2013 05:39 PM, Alexander Stein wrote:
>> Hello Marc,
>>
>> On Monday 07 October 2013 16:40:38, Marc Kleine-Budde wrote:
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>>> index bda1888..969d3cd 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -486,6 +486,29 @@ void can_bus_off(struct net_device *dev)
>>>  }
>>>  EXPORT_SYMBOL_GPL(can_bus_off);
>>> =20
>>> +static void can_berr_restart(unsigned long data)
>>> +{
>>> +	struct net_device *dev =3D (struct net_device *)data;
>>> +	struct can_priv *priv =3D netdev_priv(dev);
>>> +
>>> +	netdev_dbg(dev, "berr-restart\n");
>>> +	priv->do_berr_restart(dev);
>>      ^^^^^^^^^^^^^^^^^^^^^^^^
>> see below!
>>
>>> +}
>>> +
>>> +void can_berr_limit(struct net_device *dev)
>>> +{
>>> +	struct can_priv *priv =3D netdev_priv(dev);
>>> +
>>> +	if (priv->berr_limit_delay) {
>>> +		netdev_dbg(dev, "berr-limit\n");
>>> +		mod_timer(&priv->berr_limit_timer,
>>> +			  jiffies + priv->berr_limit_delay);
>>> +	} else {
>>> +		priv->do_berr_restart(dev);
>>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>=20
>> Here you are silently requiring that do_berr_restart is non-NULL. I
>> know that the driver has to properly set this when using
>> can_berr_limit, but it might seem confusing.
>=20
> If the driver wants to make use of this feature, it has to setup this
> callback. If I add NULL pointer checks, the kernel wouldn't blow up, bu=
t
> the driver doesn't work any more.

I mean, if the driver doesn't setup the callback and there is a NULL
pointer checks in both functions, the driver doesn't work properly,
because the bus error interrupts will stay disabled and you might not
notice it, because there isn't any big sign of failure (like the NULL
pointer deref).

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--n6VL6nakFs4oJQXa643w1fDak3Xi9j6jw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJS2q0ACgkQjTAFq1RaXHMdOgCePGCG2FKxKCsQiWyEam0oz6R9
vXUAoJbS6Ix2gNgNUl+zGbgmflPSiTFm
=BiCf
-----END PGP SIGNATURE-----

--n6VL6nakFs4oJQXa643w1fDak3Xi9j6jw--
