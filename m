From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 5/7] can: dev: add berr_limit infrastrucutre
Date: Tue, 08 Oct 2013 09:05:12 +0200
Message-ID: <5253AEA8.1080100@pengutronix.de>
References: <1381156840-24071-1-git-send-email-mkl@pengutronix.de> <5252D9BE.9040905@pengutronix.de> <5252DAAD.1020009@pengutronix.de> <3564375.WErYyL6CN1@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="P28uF6QVf9FXn945pkvHJITwD7mJfBdR7"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45894 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754491Ab3JHHFZ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Oct 2013 03:05:25 -0400
In-Reply-To: <3564375.WErYyL6CN1@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--P28uF6QVf9FXn945pkvHJITwD7mJfBdR7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/08/2013 08:03 AM, Alexander Stein wrote:
> On Monday 07 October 2013 18:00:45, Marc Kleine-Budde wrote:
>>>>> +void can_berr_limit(struct net_device *dev)
>>>>> +{
>>>>> +	struct can_priv *priv =3D netdev_priv(dev);
>>>>> +
>>>>> +	if (priv->berr_limit_delay) {
>>>>> +		netdev_dbg(dev, "berr-limit\n");
>>>>> +		mod_timer(&priv->berr_limit_timer,
>>>>> +			  jiffies + priv->berr_limit_delay);
>>>>> +	} else {
>>>>> +		priv->do_berr_restart(dev);
>>>>          ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>
>>>> Here you are silently requiring that do_berr_restart is non-NULL. I
>>>> know that the driver has to properly set this when using
>>>> can_berr_limit, but it might seem confusing.
>>>
>>> If the driver wants to make use of this feature, it has to setup this=

>>> callback. If I add NULL pointer checks, the kernel wouldn't blow up, =
but
>>> the driver doesn't work any more.
>>
>> I mean, if the driver doesn't setup the callback and there is a NULL
>> pointer checks in both functions, the driver doesn't work properly,
>> because the bus error interrupts will stay disabled and you might not
>> notice it, because there isn't any big sign of failure (like the NULL
>> pointer deref).
>=20
> Mh, what would be the effect if a driver doesn't setup the callback
> and still uses can_berr_limit? The NULL dereference raises and OOPS
> and what then? The corresponding application gets killed? Well if the
> system as a whole still works and even better then faulty driver can
> be unloaded again, this might be suitable.

It makes no sense to use can_berr_limit() without implementing the
callback. So it makes no sense from my point of view to add a NULL
pointer check.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--P28uF6QVf9FXn945pkvHJITwD7mJfBdR7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJTrqgACgkQjTAFq1RaXHNhZQCfXsjnmn4HRtuVj9YADmiJyhYK
OscAnRxUj2RUMjBYYSqCzLxte5QM+j1L
=Tc74
-----END PGP SIGNATURE-----

--P28uF6QVf9FXn945pkvHJITwD7mJfBdR7--
