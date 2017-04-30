From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] Enabling rcar_can changelink support
Date: Sun, 30 Apr 2017 21:30:32 +0200
Message-ID: <010b1e25-0bc3-906e-6fb1-7a386aa0162f@pengutronix.de>
References: <1493495283-55306-1-git-send-email-Bogdan-Stefan_mirea@mentor.com>
 <01f8d1b7-0ef2-a13e-b626-5026b4409a7c@pengutronix.de>
 <0a97b4ea6a2f494c8f597a8e69025621@svr-ies-mbx-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Vp4jQP3u3paHuklghHG1IWulqd863TCL0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:37907 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1948624AbdD3Tap (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 30 Apr 2017 15:30:45 -0400
In-Reply-To: <0a97b4ea6a2f494c8f597a8e69025621@svr-ies-mbx-01.mgc.mentorg.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Mirea, Bogdan-Stefan" <Bogdan-Stefan_Mirea@mentor.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, "socketcan@hartkopp.net" <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vp4jQP3u3paHuklghHG1IWulqd863TCL0
Content-Type: multipart/mixed; boundary="Wsavet7Ns0QIgAHEmSQHoHjo7RSq47L11";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: "Mirea, Bogdan-Stefan" <Bogdan-Stefan_Mirea@mentor.com>,
 "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "socketcan@hartkopp.net" <socketcan@hartkopp.net>
Message-ID: <010b1e25-0bc3-906e-6fb1-7a386aa0162f@pengutronix.de>
Subject: Re: [PATCH] Enabling rcar_can changelink support
References: <1493495283-55306-1-git-send-email-Bogdan-Stefan_mirea@mentor.com>
 <01f8d1b7-0ef2-a13e-b626-5026b4409a7c@pengutronix.de>
 <0a97b4ea6a2f494c8f597a8e69025621@svr-ies-mbx-01.mgc.mentorg.com>
In-Reply-To: <0a97b4ea6a2f494c8f597a8e69025621@svr-ies-mbx-01.mgc.mentorg.com>

--Wsavet7Ns0QIgAHEmSQHoHjo7RSq47L11
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/30/2017 01:33 PM, Mirea, Bogdan-Stefan wrote:
> Hello Marc,
>=20
>> On 04/29/2017 09:48 PM, Bogdan Mirea wrote:
>>> Added rcar_can_set_bittiming as can.do_set_bittiming callback that
>>> will be called from can_changelink generic callback when link state
>>> is=20
>>> changed.
>>>
>>> This enables set bittiming support:
>>>     ip link set can0 type can bitrate 500000 triple-sampling on
>>
>> Why is this needed? rcar_can_set_bittiming() is called during
>> rcar_can_open().
>=20
> I know that rcar_can_set_bittiming() is called during rcar_can_open()
> and setting bittiming works fine when setting can up with a command
> like:
> (1st approah)
>     $ip link set can0 up type can bitrate 500000
>=20
> But most of tutorials online[1] are presenting as a TODO the following
> pair of commands:
> (2nd approah)
>     $ip link set can0 type can bitrate 500000
>     $ip link set up can0
>=20
> And in this 2nd approah, the first command will fail since it will call=

> can_changelink which on its turn will try calling .do_set_bittiming
> callback and the former callback is not defined for rcar_can.

Why should it fail?

>                 memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(=
bt));
>                 err =3D can_get_bittiming(dev, &bt,
>                                         priv->bittiming_const,
>                                         priv->bitrate_const,
>                                         priv->bitrate_const_cnt);
>                 if (err)
>                         return err;
>                 memcpy(&priv->bittiming, &bt, sizeof(bt));

Here the bittiming settings are copied to priv->bittiming
>=20
>                 if (priv->do_set_bittiming) {
>                         /* Finally, set the bit-timing registers */
>                         err =3D priv->do_set_bittiming(dev);
>                         if (err)
>                                 return err;
>                 }

and it will only call the set_bittiming if it's defined.

> I don't say this is a must-have feature, since calling iproute2 with
> "set bitrate" and "set can up"  as in 1st approach will work just fine,=

> will work just fine, but it is a nice to have feature for the second
> approach of setting bitrate.
> Also peak_usb pcan[2] uses this second approach (the changelink one) an=
d
> this patch updates rcar_can for it.

Sorry I still don't get why this is necessary.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--Wsavet7Ns0QIgAHEmSQHoHjo7RSq47L11--

--Vp4jQP3u3paHuklghHG1IWulqd863TCL0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAlkGO1gACgkQHv7KIOw4
HPaNIwf6A/KbgkOrIogv/VP1QQOOHmsmAlRD4oCombGWblgvC/ihXo8gnMr+49cf
4Q5EKeYUyTnqXKE8LOk1d6wc/oCh9PTPYali2twHuSIfWLIptT2L2F/kVAX7ipPE
C5IpdGL+UwWwVRfyUEC3/jUgWz/AoYpLZv362Q654mcBnqKgSZxTcAMfbNJuZx7v
HXiTgFFnL6dQZi3jf9fDi5Ihkaq9sJRulP3E7RNjtOqqqgZ/Aswhs5BWAX1MjfXj
6UxXqtDQS9TjYDezcVXYQ9yImhY0c6rqfoihg4eMeYMKd/7s7nkYVuHC9pVMN7dP
c8XyzRkggxItzIrD3J9RwHkEhT5Hdw==
=TNK+
-----END PGP SIGNATURE-----

--Vp4jQP3u3paHuklghHG1IWulqd863TCL0--
