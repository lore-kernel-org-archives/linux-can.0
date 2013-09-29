From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: autobaud detection (was: Re: adding can4linux to drivers/char)
Date: Sun, 29 Sep 2013 21:43:27 +0200
Message-ID: <524882DF.2050604@pengutronix.de>
References: <1881932.U1kQQJkqCz@heinz.site> <523DF9C1.30300@grandegger.com>  <2109885.0l6dWmo4a5@heinz.site>  <CADGMhsXTbEc5ifQEbNM=dS3OP6uwGrvGfZ3OCvWJ=aXJyzGs+A@mail.gmail.com>  <52487518.80008@pengutronix.de> <1380482622.14050.15.camel@blackbox>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4CcLmqfq2jcCKmp7qoe2ePDmbQGJoEHf1"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54476 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755345Ab3I2UA5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 29 Sep 2013 16:00:57 -0400
In-Reply-To: <1380482622.14050.15.camel@blackbox>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Max S." <max@schneidersoft.net>
Cc: Sebastian Haas <dev@sebastianhaas.info>, =?UTF-8?B?SGVpbnotSsO8cmdlbiA=?= =?UTF-8?B?T2VydGVs?= <hj.oertel@t-online.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4CcLmqfq2jcCKmp7qoe2ePDmbQGJoEHf1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/29/2013 09:23 PM, Max S. wrote:
> This isn't on topic to this thread...

I've changed the topic :P

> Just thought I'd note:

Thanks.

> On Sun, 2013-09-29 at 20:44 +0200, Marc Kleine-Budde wrote:
>> If there is a need for bitrate detection, feel free request it here. I=

>> think there are some controllers that support this in hardware, while
>> others don't. Is there a known working algorithm for bitrate detection=
?
>=20
> Most controllers have listen only mode, in which the error counters are=

> frozen. It is then possible to systematically try all common bit-rate
> configurations, and listen for good frames. works best when you start
> with high speeds and work your way down. Listen only mode baud sniffing=

> will require at least two other nodes (one to send, one to ack..)

This sounds pretty straight forward. This can be implemented as a
userspace library. Pseudo code:

The function get the can interface name as a string, an optional  0
terminated array of bitrates (must be sorted or we sort internally) if
NULL a default array is used, a pointer to an int that will be written
if the bitrate is found and a timeout value in ms. The code waits for X
ms for a good frame to arrive.

int can_autobitrate(const char *interface, const int bitrate_array[],
                    int *autobitrate, int timeout_ms)
{
	struct pollfd fds[1];
	int s, ret =3D 0;

	err =3D can_set_listenonly(interface);
	if (err)
		return err;

	s =3D socket(interface);
	fds[1].fd =3D s;
	fds[1].events =3D POLLIN;

	if (!bitrate_array)
		bitrate_array =3D default_bitrate_array;

	for (i =3D 0; bitrate_array[i]; i++) {
		can_ifdown(interface);
		can_set_bitrate(interface, bitrate_array[i]);
		can_ifup(interface);

		/* wait for good frame comming in */
		ret =3D poll(fds, 1, timeout_ms);
		if (ret =3D=3D 1 && fds[1].revents & POLLIN) {
			*bitrate =3D bitrate_array[i];
			goto out:
		}
		proper_error_handling();
	}
	ret =3D -1;

out:
	close(s);
	set_normal_mode(interface);
}


> Some controllers also have a mode similar to listen only, but that also=

> internally connect the TX signal to the RX signal. this way you only
> need 1 other node to send non acked frames. the autobauding node will
> then ack those frames for itself only. Atmel calls this mode LOOPBACK..=
=2E
> even though its not a typical "LOOPBACK".

This new mode can be easily added to the other control mode, we just
have to define a proper name.

> Additionally when using micros with on-board CAN controllers the RX pin=

> can be temporarily reprogrammed to an input. With a pin change interrup=
t
> and a timer it is then possible to measure the TQ used by other nodes.

Nice, with modern Device Tree based Kernels that is also possible. You
can describe alternative pinmux settings for a device in a hardware
independent way.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4CcLmqfq2jcCKmp7qoe2ePDmbQGJoEHf1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJIgt8ACgkQjTAFq1RaXHOLEACgk8iikXtEpQZp2gbVo+eW260M
9jMAmwYBHQosf5q2tEMoKnqu3j6bxD5j
=Zta3
-----END PGP SIGNATURE-----

--4CcLmqfq2jcCKmp7qoe2ePDmbQGJoEHf1--
