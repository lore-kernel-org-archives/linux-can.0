From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: Writing socketCAN module for my own hardware
Date: Tue, 12 Aug 2014 12:01:56 +0200
Message-ID: <53E9E614.7060303@pengutronix.de>
References: <53E9C774.3040401@ep1.ruhr-uni-bochum.de> <53E9CF27.90400@pengutronix.de> <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="TCNe1cpfSEdt7oEmpm7iVrED0ssgqVK4j"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:57609 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbaHLKCC (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 12 Aug 2014 06:02:02 -0400
In-Reply-To: <53E9D6F3.4050206@ep1.ruhr-uni-bochum.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TCNe1cpfSEdt7oEmpm7iVrED0ssgqVK4j
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/12/2014 10:57 AM, Florian Feldbauer wrote:
> On 08/12/2014 10:24 AM, Marc Kleine-Budde wrote:
>> On 08/12/2014 09:51 AM, Florian Feldbauer wrote:
>>> I have developed a CAN interface for the Raspberry Pi computer using =
the
>>> SJA1000 directly connected to the GPIOs of the CPU.
>> This sounds very slow :)
> Actually no. At least with the chardev driver it was faster than the
> PEAK USB-CAN-PRO
> connected to my laptop.
> But I'm using direct memory manipulation to set/clear the GPIOs.
> This is much faster than using the designated GPIO functions from the
> kernel...

Portability comes with a price.

>>> So far this interface is used as chardev and works fine.
>>> But I'm also developing a user-space program using this CAN interface=
=2E
>>> This program should also be compatible with other CAN interfaces like=

>>> the ones from PEAK or Kvazer. So I thought using socketCAN would be a=

>>> good idea.
>> Yes.
>>
>>> Is there any documentation on how to write a socketCAN compatible ker=
nel
>>> module for my own hardware?
>>> I tried writing something similar to the sja1000_isa driver...
>> IMHO sja1000_platform.c is a better blueprint, as it uses the device
>> tree to describe the hardware and does not rely on module parameters.
> Ok. I will have a look at it.
>>
>>> So far my modified kernel compiles and I can change bitrate and bring=

>>> the interface up.
>>> But as soon as I try to send a CAN frame I get the error:
>>> Error 105: No buffer space available
>> You are sending CAN frames faster than the driver is able to send them=
,
>> you have to wait a bit, before sending new CAN frames.
> I'm using
>   int nbytes =3D write( fd, pframe, sizeof(can_frame_t) );
> to send a message. I thought this function blocks until the write is
> finished?

No. It will return with a errno if the message cannot be queued.

> My old chardev module was based on the kernel module from PEAK systems =
and
> thus had a FIFO buffer for sending and receiving messages.
> From the above error, I assume, socketCAN has no internal buffer?

There are buffers for RX and TX.

> What happens if there are many messages received on a small timescale?

If the system can handle the RX load all messages will be queued. Then
there are per socket queues for your userspace applications. If a queue
if full, CAN frames will be dropped. You can get information about
dropped CAN frames with the recvmsg() system call. See candump.c from
the gitorious can-utils for an exmaple.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--TCNe1cpfSEdt7oEmpm7iVrED0ssgqVK4j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPp5hQACgkQjTAFq1RaXHNZ6ACfVaJy8UB9jtJVT39I7NZpYpVa
S4wAn2iptamGVXVgrssyQVb2BRSrz24E
=slsI
-----END PGP SIGNATURE-----

--TCNe1cpfSEdt7oEmpm7iVrED0ssgqVK4j--
