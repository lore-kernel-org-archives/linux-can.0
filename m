From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH can-next v5 1/2] can: add tx/rx LED trigger support
Date: Wed, 01 Aug 2012 14:18:45 +0200
Message-ID: <50191EA5.1040303@pengutronix.de>
References: <5018F8B3.6080404@pengutronix.de> <1343821782-1346-1-git-send-email-fabio.baltieri@gmail.com> <1920193464.85058.1343822773242.JavaMail.open-xchange@webmail.strato.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3C570057AD755E341A46A0A4"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47093 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751993Ab2HAMSt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 1 Aug 2012 08:18:49 -0400
In-Reply-To: <1920193464.85058.1343822773242.JavaMail.open-xchange@webmail.strato.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can@vger.kernel.org, Fabio Baltieri <fabio.baltieri@gmail.com>, linux-kernel@vger.kernel.org, Wolfgang Grandegger <wg@grandegger.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3C570057AD755E341A46A0A4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2012 02:06 PM, Oliver Hartkopp wrote:
> Sorry for this potentially mangled mail from my webmail access ...
>=20
> Fabio Baltieri <fabio.baltieri@gmail.com> hat am 1. August 2012 um 13:4=
9
> geschrieben:
>=20
>> +void devm_can_led_init(struct net_device *netdev)
>> +{
>> +  struct can_priv *priv =3D netdev_priv(netdev);
>> +  void *res;
>> +
>> +  res =3D devres_alloc(can_led_release, 0, GFP_KERNEL);
>> +  if (!res)
>> +          goto err_out;
>> +
>> +  priv->tx_led_trig_name =3D kasprintf(GFP_KERNEL, "%s-tx", netdev->n=
ame);
>=20
> IMO putting a string with 8 or 9 bytes into a separate kmalloc memory s=
niplet is
> pretty oversized.
> Ok - these functions provide to hide the complexitiy for allocating and=
 storing
> strings, which is
> definitely fine for path names and these kind of strings that are not k=
nown in
> length and probably
> more than 100 bytes long.
>=20
> But in this case i would suggest to allocate a fixed space in can_priv,=
 as we
> know the string length
> very good (IFNAMSZ + strlen("-tx")) and there's no reason to get all th=
e
> overhead from three kmallocs
> instead of one for that small memory allocations.
>=20
> So i would suggest:
>=20
>> @@ -52,6 +53,13 @@ struct can_priv {
>>
>>    unsigned int echo_skb_max;
>>    struct sk_buff **echo_skb;
>> +
>> +#ifdef CONFIG_CAN_LEDS
>> +  struct led_trigger *tx_led_trig;
>> +  char *tx_led_trig_name;
>=20
> char tx_led_trig_name[IFNAMSZ+4];
>=20
>> +  struct led_trigger *rx_led_trig;
>> +  char *rx_led_trig_name;
>=20
> char rx_led_trig_name[IFNAMSZ+4];
>=20
>> +#endif
>>  };

Sounds reasonable. Please Introduce a #define for "IFNAMSZ + 4" and
document where the 4 comes from. Send a v6 patch, I'll force update the
git repo, after you have Oliver's Acked-by.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig3C570057AD755E341A46A0A4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAZHqYACgkQjTAFq1RaXHO0egCeJgHqkhU5BiBVPnBpR2UbQRHc
qYQAnit7W6KyadOyZDa8pHt+x3KG8kES
=qGOc
-----END PGP SIGNATURE-----

--------------enig3C570057AD755E341A46A0A4--
