From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Acknowledging messages with SocketCAN
Date: Tue, 04 Jun 2013 18:33:47 +0200
Message-ID: <51AE16EB.6080209@pengutronix.de>
References: <CALr1zciumzF8ijW-o4YabN3oi=wf+Ph9N9XSH+b=b1UPQhgzww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NSNHQLUPWIKUFXBJMTDX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47589 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab3FDQd4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 4 Jun 2013 12:33:56 -0400
In-Reply-To: <CALr1zciumzF8ijW-o4YabN3oi=wf+Ph9N9XSH+b=b1UPQhgzww@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mike Mogenson <michael.mogenson@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NSNHQLUPWIKUFXBJMTDX
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello Mike,

please use the linux-can mailinglist (Cc'ed)

On 06/04/2013 06:21 PM, Mike Mogenson wrote:
> First, thank you for your project. =20

I'm just one of the developers working on this project, you're welcome.

> Second, I'm using your can-utils on a BeagleBone running Ubuntu with th=
e
> 3.2 kernel.  Everything is working well with my can0 device in loopback=

> mode.  However, when I connect a CAN enabled motor controller to the
> CANbus, the BeagleBone doesn't appear to acknowledge the motor
> controller's heartbeat message and the motor controller retries its
> message over and over.

It's normal behaviour that a CAN node repeats the message if it is not
acked on the bus.

> I don't see anything with candump or in
> /proc/net/can/stats, but I can see the message repeating over and over
> with an oscilloscope on the CANbus.

Ensure that your CAN network is properly terminated on both ends (120 Ohm=
s).

Configure the bitrate of your d-can correctly, it must be the same as
the bitrate of your motor. With canutils:

    canconfig can0 bitrate 1250000

or iproute2's ip (the "ip" from busybox doesn't work):

    ip link set can0 type can bitrate 125000

Then activate your CAN:

    ifconfig can0 up

> Do I have to configure SocketCAN on the BeagleBone
> to acknowledge messages?  How can I set the BeagleBone to have a
> specific Node ID?  To my knowledge, the heartbeat message is not
> directed at a specific Node ID, but I will eventually need to direct
> messages from CAN devices to the BeagleBone.

regards,
Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


------enig2NSNHQLUPWIKUFXBJMTDX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlGuFu4ACgkQjTAFq1RaXHOrJACfUrnGry5WnTHTQKopKJigpNln
gBkAnjUmXcIEvN/dEDRgRJdzNEJ8dglc
=2lhq
-----END PGP SIGNATURE-----

------enig2NSNHQLUPWIKUFXBJMTDX--
