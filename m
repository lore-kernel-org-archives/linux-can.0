From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 14:19:40 +0100
Message-ID: <4F69D56C.9050607@pengutronix.de>
References: <20120321091055.GA433@vandijck-laurijssen.be> <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de> <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de> <20120321125130.GC3372@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6C751E7BCCA69E0D747C602E"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40412 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758782Ab2CUNTw (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Mar 2012 09:19:52 -0400
In-Reply-To: <20120321125130.GC3372@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: dev@sebastianhaas.info, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6C751E7BCCA69E0D747C602E
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2012 01:51 PM, Kurt Van Dijck wrote:
>>>> What about
>>>> the RX path? We can just use the new 64 byte CAN frames and have to
>>>> tweak the CAN_RAW if the read from the userspace is too small.
>>> You may have noticed that I did not need to do anything
>>> in the receive path in order to receive longer frames.
>>>
>>> look at this block in raw_recvmsg:
>>>
>>> 	if (size < skb->len)
>>> 		msg->msg_flags |=3D MSG_TRUNC;
>>> 	else
>>> 		size =3D skb->len;
>>>
>>> Even today already, you can recv. with smaller or bigger buffers than=

>>> the actual CAN frame.
>>
>> ...using an unmodified mainline kernel?
>=20
> Must be. yes!
> I think that's good.

Indeed. I wasn't aware of this.

>>> I did try to let the kernel work with 64bytes, and still use
>>> 8byte frames in userspace. that all works, especially since noone
>>> seems to test for MSG_TRUNC.
>>
>> Have you checked _all_ CAN userspace applications? :P
>> We cannot break the ABI.
> I mentioned cansend & candump.
> I realize there's a lot of work ahead. I just started, and tried
> not to touch too much, and yet prove it can work.
>=20
> I agree that we cannot break the current ABI.
>=20
>>
>>> An improvement that just crosses my mind is something like:
>>>
>>> 	int real_len;
>>>
>>> 	real_len =3D offsetof(struct can_frame, data) +
>>> 		((struct can_frame)skb->data)->dlc;
>>> 	if (size < real_len)
>>> 		msg->msg_flags |=3D MSG_TRUNC;
>>> 	else
>>> 		size =3D real_len;
>>>
>>> Such would modify the ABI a bit more, but prevents copying unused byt=
es
>>> and avoids unnecessary MSG_TRUNC flags.
>>
>> I suggest to copy the full 8 bytes of data if dlc <=3D 8, for full ABI=

>> compatibility.
>=20
> Do we then agree that it is desired not to do this beyond the first 8 b=
ytes?
> Moreover, we could depend this on the function parameter 'size'. If it
> is 16bytes, do as before, else do the new trick. Did I miss something t=
hen?

Yes, if 16 bytes is the length of the current struct can_frame.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig6C751E7BCCA69E0D747C602E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9p1W8ACgkQjTAFq1RaXHPNAgCdEH+00+4y+KTk2ZRvKY7iyhDz
yhgAn05DyF8WZXYMBa/OVtHzUtopxtQQ
=Zv5+
-----END PGP SIGNATURE-----

--------------enig6C751E7BCCA69E0D747C602E--
