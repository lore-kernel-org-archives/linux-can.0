From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 13:32:52 +0100
Message-ID: <4F69CA74.3020607@pengutronix.de>
References: <20120321091055.GA433@vandijck-laurijssen.be> <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de> <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig187EDB8F53A4EE7D17307760"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38639 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755914Ab2CUMdD (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Mar 2012 08:33:03 -0400
In-Reply-To: <20120321120846.GB3372@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: dev@sebastianhaas.info, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig187EDB8F53A4EE7D17307760
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 03/21/2012 01:08 PM, Kurt Van Dijck wrote:
> On Wed, Mar 21, 2012 at 12:43:31PM +0100, Marc Kleine-Budde wrote:
>> On 03/21/2012 12:05 PM, Kurt Van Dijck wrote:
>>> Hi Sebastian,
>>>
>>> On the ICC, Bosch presentend CANFD[1].
>>> I'll share my interpretation:
>>> * CANFD is meant as a successor of CAN.
>>> * it addressess data throughput in 2 ways:
>>>   - higher data bitrate for data using a second
>>>     set of bittimings.
>>>   - longer message payload (up to 64 byte).
>>> * it remains very compatible to CAN, although _NOT_
>>>   bus-compatible (ie. you put it on a seperate bus).
>>
>> This means:
>> You cannot have a Bus using one (or more) of the CAN-FD features with
>> non CAN-FD compatible nodes.
>>
>> From my point of view this can be translated into a new property in
>> "can.ctrlmode_supported". A device adds "CAN_CTRLMODE_CANFD" if it
>> supports CAN FD mode. Then it's a global setting to put the device int=
o
>> CAN FD mode.
> Yep, good idea.
>>
>> In the TX path the stack should refuse the new 64 byte frames at all o=
r
>> frames with dlc > 8 byes if the device is not in CAN FD mode.
> I did not yet do such think since I did not implement CANFD on device l=
evel yet.
> I think can_send() is a good place to put such tricks.

Yes, for CAN_RAW, but in the driver we must extend the
"can_dropped_invalid_skb()" function, too: drop frames with dlc >8 if
device is not in CAN FD mode.

Further, there are only certain dlc values allowed for CAN FD. We must
decide if the enforce these values or simply do padding with "0" somewher=
e.

>> What about
>> the RX path? We can just use the new 64 byte CAN frames and have to
>> tweak the CAN_RAW if the read from the userspace is too small.
> You may have noticed that I did not need to do anything
> in the receive path in order to receive longer frames.
>=20
> look at this block in raw_recvmsg:
>=20
> 	if (size < skb->len)
> 		msg->msg_flags |=3D MSG_TRUNC;
> 	else
> 		size =3D skb->len;
>=20
> Even today already, you can recv. with smaller or bigger buffers than
> the actual CAN frame.

=2E..using an unmodified mainline kernel?

> I did try to let the kernel work with 64bytes, and still use
> 8byte frames in userspace. that all works, especially since noone
> seems to test for MSG_TRUNC.

Have you checked _all_ CAN userspace applications? :P
We cannot break the ABI.

> An improvement that just crosses my mind is something like:
>=20
> 	int real_len;
>=20
> 	real_len =3D offsetof(struct can_frame, data) +
> 		((struct can_frame)skb->data)->dlc;
> 	if (size < real_len)
> 		msg->msg_flags |=3D MSG_TRUNC;
> 	else
> 		size =3D real_len;
>=20
> Such would modify the ABI a bit more, but prevents copying unused bytes=

> and avoids unnecessary MSG_TRUNC flags.

I suggest to copy the full 8 bytes of data if dlc <=3D 8, for full ABI
compatibility.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enig187EDB8F53A4EE7D17307760
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk9pyngACgkQjTAFq1RaXHMDigCdFaM+dO8i43bhlpKx5Vx+IiFz
e0YAn17al/OUbUjjZ4uSp7t1s6AWshMd
=kmTw
-----END PGP SIGNATURE-----

--------------enig187EDB8F53A4EE7D17307760--
