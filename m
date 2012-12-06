From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC v2 0/7] pch_can/c_can: fix races and add PCH support to
 c_can
Date: Thu, 06 Dec 2012 15:02:39 +0100
Message-ID: <50C0A57F.70304@pengutronix.de>
References: <1354199987-10350-1-git-send-email-wg@grandegger.com> <4250988.UdN8LQq6de@ws-stein> <50BF85DD.6090809@grandegger.com> <4036287.fuKZ6k5idx@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF8B310FAAD3C65A3C13EDF29"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:54070 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754771Ab2LFOCt (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 6 Dec 2012 09:02:49 -0500
In-Reply-To: <4036287.fuKZ6k5idx@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org, bhupesh.sharma@st.com, tomoya.rohm@gmail.com

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF8B310FAAD3C65A3C13EDF29
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/06/2012 02:38 PM, Alexander Stein wrote:
>>> On the second line you can see that the register isn't written at all=
 (or the=20
>>> read failed for some reason).
>>
>> I assume the latter. Could you please retry reading the register until=

>> the correct value shows up. With some timeout, of course.
>=20
> I notices having all error events printed on serial console using
> pch_uart driver has negative effect (I guess one problem causes
> another one), so I setup 'dmesg -n1' to reduce serial load before the
> test. Running the test with just one heartbeat triggered LED set
> using I2C the test runs without errors. I only see Lots of 'c_can_pci
> 0000:02:0c.3: can0: write 0x0 to offset 0x2c failed. got: 0x2000' at
> the beginning. It seems this (reserved?) bit is always 1 no matter
> what we write. But things start to break when running the test while
> running 'watch sensors' (sensors queries several temperature sensors
> via I2C) in a seconds ssh session. First off the driver error
> messages (omitting the messages as written above):

Hmmm, maybe there is a hardware problem, that would not be the first one
we've seen in CAN hardware.

> [  384.466217] c_can_pci 0000:02:0c.3: can0: write 0x73 to offset 0x24 =
failed. got: 0xbc
[...]
> [  700.647000] c_can_pci 0000:02:0c.3: can0: write 0x0 to offset 0x0 fa=
iled. got: 0x88

Your spin lock patches look good. I think it's time to get in contact
with your Intel support and try to get through to the hardware people
that can look into the VHDL code.

> As you can see, sometimes it needs several write retries to succeed.
> Nevertheless my test application detects also some problems:

>> Error on MSG ID 0x252. Got counter 96480 and expected 96466
>> Error on MSG ID 0x251. Got counter 96480 and expected 96466
>> Error on MSG ID 0x252. Got counter 101706 and expected 101696
>> Error on MSG ID 0x251. Got counter 101706 and expected 101696
> Here were messages missed/dropped for both CAN-IDs.

Drops can happen at the hardware level, rx-overflow, or in the socket
queueing in linux. Look in the driver if it reports rx-overflows
properly and look at the stats. There also is a flag that indicates
frame drop at the linux socket level, but I don't remember it.

>> Error on MSG ID 0x251. Got counter 108673 and expected 108672
>> Error on MSG ID 0x251. Got counter 108672 and expected 108674
>> Error on MSG ID 0x251. Got counter 108674 and expected 108673
>                                      ^^^^^^
> Here you can see the CAN frame with counter 108673 is read before 10867=
2.

This is a typical out-of-sequence reception with a
RX-goes-into-first-free-mailbox hardware. I've implemented the algorithm
used in the at91 and fixed the one for the ti_hecc.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--------------enigF8B310FAAD3C65A3C13EDF29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iEYEARECAAYFAlDApYMACgkQjTAFq1RaXHM6CwCeKNLLpB57P8q3OeuLWm+1ZWdP
xjQAnAg25o9a4hQ51OE/44cDd9AoraW3
=OfmE
-----END PGP SIGNATURE-----

--------------enigF8B310FAAD3C65A3C13EDF29--
