From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] can: kvaser_usb: fix usb endpoints detection
Date: Mon, 28 Oct 2013 13:26:32 +0100
Message-ID: <526E57F8.6070802@pengutronix.de>
References: <1382908073-6865-1-git-send-email-olivier@sobrie.be> <526DA1DB.9000600@pengutronix.de> <20131028120534.GA19060@hposo>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="g0SggNEMs752EQLGBSg6cNeBhnd4VLAqs"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51539 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756004Ab3J1M0k (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 28 Oct 2013 08:26:40 -0400
In-Reply-To: <20131028120534.GA19060@hposo>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Olivier Sobrie <olivier@sobrie.be>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g0SggNEMs752EQLGBSg6cNeBhnd4VLAqs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/28/2013 01:06 PM, Olivier Sobrie wrote:
> On Mon, Oct 28, 2013 at 12:29:31AM +0100, Marc Kleine-Budde wrote:
>> On 10/27/2013 10:07 PM, Olivier Sobrie wrote:
>>> Some devices, like the Kvaser Memorator Professional, have several
>>> bulk in endpoints. Only the first one found should be used by the
>>> driver. The same holds for the bulk out endpoint.
>>
>> Can you give reference where this information comes from? e.g.
>> documentation or another driver?
>=20
> Someone using a Kvaser Memorator contacted me and said that its device =
was
> not working. I found out that the usb endpoint used was not correct and=
 I
> saw in the Kvaser official driver (leaf) that the detection was made
> similarly to what is done in the patch below.
> So the reference is the "leaf" driver of Kvaser.
>=20
>>
>>> Signed-off-by: Olivier Sobrie <olivier@sobrie.be>
>>> ---
>>>  drivers/net/can/usb/kvaser_usb.c | 7 ++++---
>>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/can/usb/kvaser_usb.c b/drivers/net/can/usb/k=
vaser_usb.c
>>> index 3b95465..bdbf5bf 100644
>>> --- a/drivers/net/can/usb/kvaser_usb.c
>>> +++ b/drivers/net/can/usb/kvaser_usb.c
>>> @@ -1554,13 +1554,14 @@ static void kvaser_usb_get_endpoints(const st=
ruct usb_interface *intf,
>>> =20
>>>  	iface_desc =3D &intf->altsetting[0];
>>> =20
>>> -	for (i =3D 0; i < iface_desc->desc.bNumEndpoints; ++i) {
>>> +	for (i =3D 0; (i < iface_desc->desc.bNumEndpoints) && (!*in || !*ou=
t);
>>> +	     ++i) {
>>>  		endpoint =3D &iface_desc->endpoint[i].desc;
>>> =20
>>> -		if (usb_endpoint_is_bulk_in(endpoint))
>>> +		if (!*in && usb_endpoint_is_bulk_in(endpoint))
>>>  			*in =3D endpoint;
>>> =20
>>> -		if (usb_endpoint_is_bulk_out(endpoint))
>>> +		if (!*out && usb_endpoint_is_bulk_out(endpoint))
>>>  			*out =3D endpoint;
>>
>> I personally would add a break or return here, together with a short
>> comment:
>>
>> 	/* only use first endpoint for in and out */
>> 	if (*in && *out)
>> 		return;
>>
>>>  	}
>>>  }
>>>
>=20
> Fine for me. We can even maybe add a return code to the function and ch=
eck
> this return code intead of checking again (!dev->bulk_in || !dev->bulk_=
out).
> By the way, the current return code (-ENOMEM) is maybe not appropriate =
in
> case the endpoints are not found.

Good idea, have a look at v3.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--g0SggNEMs752EQLGBSg6cNeBhnd4VLAqs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJuV/gACgkQjTAFq1RaXHPL1gCfXPxEtEbcO/j/mbjaFngNyhba
Fn4AoIYI3iyNhot09bx7/SAkInlAIrxH
=0h2P
-----END PGP SIGNATURE-----

--g0SggNEMs752EQLGBSg6cNeBhnd4VLAqs--
