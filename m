From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v3 2/3] can: kvaser_usb: Utilize all possible tx URBs
Date: Thu, 12 Mar 2015 12:29:58 +0100
Message-ID: <550178B6.4090503@pengutronix.de>
References: <20150226152011.GA6075@linux> <20150311173744.GA13095@linux> <20150311173902.GB13095@linux> <5500B958.2020101@pengutronix.de> <20150312105211.GA21639@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="R2JLn12sqDjwHITOxF6c4aOrSEOnFEgDc"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150312105211.GA21639@linux>
Sender: linux-kernel-owner@vger.kernel.org
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--R2JLn12sqDjwHITOxF6c4aOrSEOnFEgDc
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/12/2015 11:52 AM, Ahmed S. Darwish wrote:
>>> @@ -1881,7 +1891,7 @@ static int kvaser_usb_init_one(struct usb_inter=
face *intf,
>>>  	if (err)
>>>  		return err;
>>> =20
>>> -	netdev =3D alloc_candev(sizeof(*priv), MAX_TX_URBS);
>>> +	netdev =3D alloc_candev(sizeof(*priv), dev->max_tx_urbs);
>>>  	if (!netdev) {
>>>  		dev_err(&intf->dev, "Cannot alloc candev\n");
>>>  		return -ENOMEM;
>>> @@ -1889,6 +1899,13 @@ static int kvaser_usb_init_one(struct usb_inte=
rface *intf,
>>> =20
>>>  	priv =3D netdev_priv(netdev);
>>> =20
>>> +	priv->tx_contexts =3D kzalloc(dev->max_tx_urbs *
>>> +				    sizeof(*priv->tx_contexts), GFP_KERNEL);
>>> +	if (!priv->tx_contexts) {
>>> +		free_candev(netdev);
>>> +		return -ENOMEM;
>>> +	}
>>
>> I'm missing a free for the priv->tx_contexts. I see two options:
>>
>=20
> Correct. Should not have missed that.
>=20
>> 1) use devm_kzalloc(), or
>> 2) move struct kvaser_usb_tx_urb_context tx_contexts[]; to the end of
>>    struct kvaser_usb_net_priv, see [1] for an example.
>>
>>    Without further testing, I think the correct alloc for that case
>>    would be:
>>        alloc_candev(sizeof(*priv + dev->max_tx_urbs *
>>                sizeof(struct kvaser_usb_tx_urb_context))
>>
>=20
> The first option looks better I guess. I'll have to check though
> if the resource handling done by devm_kmalloc() will work even
> if the probe() method fails with -ENODEV and the like...

devm does handle failing probe functions by design, while calling a
manual free() on devm allocated mem is a bug, which will cause a double
free or worse.

YMMV: for option 2 saves a mem allocation and a pointer deref for each
access of the context.

>> [1] http://stackoverflow.com/questions/2060974/dynamic-array-in-struct=
-c

> Thanks for the link. Didn't know that such a "hack" has gained
> official status by C99 :-)

:D and I think it's used in the kernel.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



--R2JLn12sqDjwHITOxF6c4aOrSEOnFEgDc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVAXi2AAoJECte4hHFiupUXaIP/A4c/zWE3TY2HetBPHxqI92J
V6zedmYIqMb9EI3AwStp+kXeO79IkRP3PGjHXXvg8Ejamj6rR2crL960xwTf8MYx
ElEWpjqu0iyf0UPFfWfi6PAQnLJculaTfc1b0ri1jZBDRfemmVZIdnVRnIezYyOi
mEMRXziq8sCpDLQq4QUSHH19fUIMnwuZgOfnYK9saAALJowV6lzrUH7JGW0akiBu
j+Ic4PLVP1IC1NTdnq2iDCjWMKD+TZaY7L+0BYuq9a9IKtBfpeAEDCNGw1jiXUfT
Zgsl5fSdpkKPQcusRZA2c49DgjtCYeyQmcHgSi9oxHiwqxyfIW970EF8NsUti78s
NbHfy1haby+DFt2eW+38XgW8t+QU5DG4k8esSrSbubtl2l5A78Q6n6XTyZJhw4o0
zIiF/zZzChk4Js3IWFK+j3Vkf+H1oQa+0fePGK48D90WIUYeyU+y5Ycgcs8F5GRt
5LOw0x35zBuJs21hbJpgt75kYq21J1dEqn0+7wYyZ7lEsoq7eyT6I6fm0yOTW9QB
RksfhQWsrQYoN0FXwEPkiVGMYUnustRFdRlI0n+kd7DMgzgh6UM6bMPHzt9SSpPA
oGD7a/u9FqJsO+N4WgJnPLCe2R9mTNBtkOqF7mFJcw7FHycwWw2C1cHeA6WvTbsj
snMDmfHn3XKAUlviT4QK
=U7mT
-----END PGP SIGNATURE-----

--R2JLn12sqDjwHITOxF6c4aOrSEOnFEgDc--
