From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Usb to can driver
Date: Wed, 26 Jun 2013 20:58:26 +0200
Message-ID: <51CB39D2.60501@pengutronix.de>
References: <1372204758.9593.13.camel@blackbox>  <a32451031b577e68f4c79750800c5d71@grandegger.com> <1372272912.3805.27.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2VPFCTDRVLKDMULANHJXF"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40156 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab3FZS6i (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Jun 2013 14:58:38 -0400
In-Reply-To: <1372272912.3805.27.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: wg <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2VPFCTDRVLKDMULANHJXF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 06/26/2013 08:55 PM, Max S. wrote:
>>> My firmware implements LOOPBACK by default. That is all frames sent b=
y
>>> the can hardware are also returned over usb. I use this effect to cal=
l
>>> can_get_echo_skb() during bulk in. To support LOOPBACK mode as per
>>> socketcan; should i also call netif_rx() durring bulk in if
>>> CAN_CTRLMODE_LOOPBACK is
>>> set?
>>
>> Message echo (normally via echo_skbs) and loopback (via
>> CAN_CTRLMODE_LOOPBACK)
>> are somehow different things. The first is a local loopback of sent
>> frames,
>> which is described here:
>>
>>   http://lxr.linux.no/#linux+v3.9.7/Documentation/networking/can.txt#L=
178
>=20
> I was confused because i was not sure if 'sent frame' meant either a)
> 'frame that has left Linux', or b) 'frame that actually made it onto th=
e
> CAN bus'. Appears I can choose either :P

b) is preferred

> For usb_8dev and ems_usb, echo via put_echo_skb happens in the USB writ=
e
> callback. (a)
>=20
> For esd_usb2 a frame is only recognized as sent when the device reports=

> it as sent. (b)
>=20
> I also noticed esd_usb2 does: dev->nets[msg->msg.txdone.net]
> Is that safe? msg->msg.txdone.net is never check if its in range...

Can you send a patch? :)

>> Does the hardware communicate a TX done event as well?
> Yes, The controller produces a TX event which happens after successful
> frame transmission. I place successfully TXed frames in the USB IN fifo=

> with their corresponding echo_ids.

This means you implement b).

>> CAN_CTRLMODE_LOOPBACK is a real hardware loopback. Normally the messag=
e
>> does not even go out to the bus mainly useful for testing. For the sof=
tware the
>> loopback message should be handled like any other incoming message.
>=20
> Ah. so CAN_CTRLMODE_LOOPBACK could be used to test data path from
> application->Linux->driver->can_hardware and back. without the need of
> an actual physical CAN bus.

Yes, this is a usecase.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2VPFCTDRVLKDMULANHJXF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlHLOdYACgkQjTAFq1RaXHPquwCeKOSi0qLBR6HA4+E3JORL1UIT
1CEAn0LWvyNv8xtWvxy0P/G1MJPRPo9W
=82NR
-----END PGP SIGNATURE-----

------enig2VPFCTDRVLKDMULANHJXF--
