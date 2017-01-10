From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] [RFCv2] can: add CAN interface termination API
Date: Tue, 10 Jan 2017 11:37:56 +0100
Message-ID: <854c167e-bedf-1af3-1d8e-461390cb79a7@pengutronix.de>
References: <20170108163506.30818-1-socketcan@hartkopp.net>
 <762d5db6-6115-af51-bbce-8d96f3b8d947@pengutronix.de>
 <3f7eaf11-1c0c-c560-906a-54b4cde46874@hartkopp.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="62EjDqJdNbMP0dev7WS2OnEBas1E931KP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:49949 "EHLO
        metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1761700AbdAJKiD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 10 Jan 2017 05:38:03 -0500
In-Reply-To: <3f7eaf11-1c0c-c560-906a-54b4cde46874@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--62EjDqJdNbMP0dev7WS2OnEBas1E931KP
Content-Type: multipart/mixed; boundary="UHDodgfuDHCx9wUnAMgjxR54wjs15TH2L";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can@vger.kernel.org
Message-ID: <854c167e-bedf-1af3-1d8e-461390cb79a7@pengutronix.de>
Subject: Re: [PATCH] [RFCv2] can: add CAN interface termination API
References: <20170108163506.30818-1-socketcan@hartkopp.net>
 <762d5db6-6115-af51-bbce-8d96f3b8d947@pengutronix.de>
 <3f7eaf11-1c0c-c560-906a-54b4cde46874@hartkopp.net>
In-Reply-To: <3f7eaf11-1c0c-c560-906a-54b4cde46874@hartkopp.net>

--UHDodgfuDHCx9wUnAMgjxR54wjs15TH2L
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 06:13 PM, Oliver Hartkopp wrote:
> Hello Marc,
>=20
> On 01/09/2017 10:25 AM, Marc Kleine-Budde wrote:
>> On 01/08/2017 05:35 PM, Oliver Hartkopp wrote:
>>> This patch adds a netlink interface to configure the CAN bus terminat=
ion of
>>> CAN interfaces.
>>>
>>> Inside the driver an array of supported termination values is defined=
:
>>>
>>> const u16 drvname_termination =3D { 60, 120, CAN_TERMINATION_DISABLED=
 };
>>
>> drvname_termination[]
>>
>=20
> Ok.
>=20
>>>
>>> struct drvname_priv *priv;
>>> priv =3D netdev_priv(dev);
>>>
>>> priv->termination_const =3D &drvname_termination;
>>> priv->termination_const_size =3D sizeof(drvname_termination);
>>
>> ARRAY_SIZE()
>=20
> When we use ARRAY_SIZE(drvname_termination) here ...

Remigiusz's patch using _len =3D ARRAY_SIZE() here and _len * (sizeof())
in the netlink interface looks nice to me.

>>> priv->termination =3D CAN_TERMINATION_DISABLED;
>>>
>>> And the funtion to set the value has to be defined:
>>>
>>> priv->do_set_termination =3D drvname_set_termination;
>>>
>>> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>> ---
>>>  drivers/net/can/dev.c            | 34 ++++++++++++++++++++++++++++++=
+++-
>>>  include/linux/can/dev.h          |  4 ++++
>>>  include/uapi/linux/can/netlink.h |  5 +++++
>>>  3 files changed, 42 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
>>> index 8d6208c0b400..f98825f6ea2e 100644
>>> --- a/drivers/net/can/dev.c
>>> +++ b/drivers/net/can/dev.c
>>> @@ -958,6 +958,27 @@ static int can_changelink(struct net_device *dev=
,
>>>  		}
>>>  	}
>>>
>>> +	if (data[IFLA_CAN_TERMINATION]) {
>>> +		u16 t =3D nla_get_u16(data[IFLA_CAN_TERMINATION]);
>>> +		int num_t =3D priv->termination_const_size / sizeof(u16);
>=20
> ... this needs to turn into
>=20
> 	int num_t =3D priv->termination_const_size;
>=20
> but ...
>=20
>>
>> ARRAY_SIZE...or see below:
>>
>>> +		int i;
>>> +
>>> +		/* check whether given value is supported by the interface */
>>> +		for (i =3D 0; i < num_t && t !=3D priv->termination_const[i]; i++)=
;
>>
>> Nitpick: unusual for() loop, better make more explicit what's going on=
:
>>
>> for (i =3D 0; i < ARRAY_SIZE(priv->termination_const_size), i++) {
>=20
> ... this does never work as it references an integer ...

Yes, doh!

[...]

>>> @@ -980,6 +1001,11 @@ static size_t can_get_size(const struct net_dev=
ice *dev)
>>>  		size +=3D nla_total_size(sizeof(struct can_bittiming));
>>>  	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST=
 */
>>>  		size +=3D nla_total_size(sizeof(struct can_bittiming_const));
>>> +	if (priv->termination_const &&
>>> +	    priv->termination_const_size) {			/* IFLA_CAN_TERMINATION_CONST=
 */
>>> +		size +=3D nla_total_size(priv->termination_const_size);
>=20
> ... this will break ...
>=20
>>> +		size +=3D nla_total_size(sizeof(u16));		/* IFLA_CAN_TERMINATION */=

>>> +	}
>>>
>>>  	return size;
>>>  }
>>> @@ -1018,7 +1044,13 @@ static int can_fill_info(struct sk_buff *skb, =
const struct net_device *dev)
>>>  	    (priv->data_bittiming_const &&
>>>  	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
>>>  		     sizeof(*priv->data_bittiming_const),
>>> -		     priv->data_bittiming_const)))
>>> +		     priv->data_bittiming_const)) ||
>>> +
>>> +	    (priv->termination_const && priv->termination_const_size &&
>>> +	     nla_put(skb, IFLA_CAN_TERMINATION_CONST,
>>> +		     priv->termination_const_size,
>=20
> ... and this too.
>=20
>>> +		     priv->termination_const) &&
>>> +	     nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination)))
>>>  		return -EMSGSIZE;
>>>
>=20
> I just wonder, which is the most readable representation here?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--UHDodgfuDHCx9wUnAMgjxR54wjs15TH2L--

--62EjDqJdNbMP0dev7WS2OnEBas1E931KP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEES2FAuYbJvAGobdVQPTuqJaypJWoFAlh0uYQACgkQPTuqJayp
JWoKBwf8DA/9WFDaM2DDh34LKC45vbRFp4scuTEDPVh1NZ0efH5CTBeq13hVcr5N
79+/gTDSXXb9drJnxcQfYBnQ464e82L/lvvOZ1cNn7sywV0RWgHiWCdXj0He7FoC
UO/KZsilqb4cY/Obp/FxH6cc8vQAojDL94U8WH5DAqWUqynBAy26K5Zye2ciYLOJ
bLDb3F94CZ6lbGcqd30URF3ij3azE2isanQkIUPqLKYIGxSadSd24tUVL7JKTkm8
FWCLhzo/+GRaZEf9LJ9uEHgKGkmkQbpqbVB5IPiUAHqs2kNNr6rpKl91ws0H3F+r
A2/R+HHE7GdgccaUBgLP5vK3pDBu/Q==
=is/H
-----END PGP SIGNATURE-----

--62EjDqJdNbMP0dev7WS2OnEBas1E931KP--
