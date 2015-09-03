From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 0/8] RFC: more flexcan cleanups and SW FIFO IRQ offloading
Date: Thu, 3 Sep 2015 08:58:21 +0200
Message-ID: <55E7EF8D.306@pengutronix.de>
References: <1441103522-15593-1-git-send-email-mkl@pengutronix.de>
 <55E78D42.1060109@optusnet.com.au> <20150903083208.29333e01@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ududAG9leSA1LwliJbcaKnDmts4bWu1kn"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48867 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754794AbbICG6h (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 Sep 2015 02:58:37 -0400
In-Reply-To: <20150903083208.29333e01@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>, Tom Evans <tom_usenet@optusnet.com.au>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ududAG9leSA1LwliJbcaKnDmts4bWu1kn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/03/2015 08:32 AM, David Jander wrote:
>>> this series adds a software FIFO implementation and switches
>>  > the flecan and at91 driver to it. It's intended for CAN cores
>>  > with a higher number of mailboxes.
>>
>> It is a bit difficult to understand the changed by looking at 20 patch=
es, so=20
>> I'm assuming this is the change where what the i.MX6 manuals calls the=
=20
>> "Reception Queue" mode is enabled.

In the first series the "real" change happens at Patch 12/12. The
hardware FIFO which was handled in NAPI now it's handled in a hard IRQ
context. It's making use of the code introduced in patch 11/12.

>> I see "[PATCH 1/8]" renaming "FLEXCAN_MCR_BCC" to "FLEXCAN_MCR_IRMQ" a=
nd=20
>> "[PATCH 2/8]" adding it to the MCR setting.

These are just preparation patches. But you're right, the MCR_IRMQ is
essential for software FIFO.

>> Use of the "Reception Queue" is documented in the i.MX6DQ manual in se=
ction=20
>> "26.6.5 Matching Process" as:
>>
>>      By programming more than one MB with the same ID, received
>>      messages will be queued into the MBs. ARM can examine the
>>      Time Stamp field of the MBs to determine the order in which
>>      the messages arrived.
>>
>> Is the new code sorting the messages by using the timestamp, or have y=
ou
>> found another way to guarantee reception order?
>=20
> Almost. Generic code in can/dev.c cannot know about special features li=
ke
> timestamps that some peripherals may provide.

Thanks to David explaining the algorithm.

The generic code is added in 5/8, the flexcan specific code is added in 7=
/8.

Regarding the time stamp feature. IIRC, the mailboxes in the AT91 have
timestamps, too. When the generic SW-FIFO code is stable and someone is
interested, sorting by timestamps can be added to the generic code base.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--ududAG9leSA1LwliJbcaKnDmts4bWu1kn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV5++QAAoJEP5prqPJtc/HukQIAK0Ag4BgyITrzqujr48rEOvW
Hl2U+OOwH0+ZyujSk6UvpOsQ5+Ykpl7ypDbmHW9SeUwsxw9IVVPY2STKKhgcsTwK
cgT1g1PSp/2UQlwtNNUBZR1rFVfjfBTf59fsOIdDvVFuyr6O3diiTtA5Ahff1j0n
wLVzzgF+7L0ZjOOilpEqH7s0JLs2hOlTRrSKPfJLaPr4I6tkxdzNXRj0QSl5fDOO
BG4ozaQ0kXKtM2oCP1TESUAfoVZf2NE3fRWKSCwQoalgKTBoz48ECVQXVA1odrf3
QLPUuo5zRBWWIrNSjt7a5lV8kVKOhKar97gvfcEWtSP0Ux1NTVkzdXywu18K+dE=
=FyzR
-----END PGP SIGNATURE-----

--ududAG9leSA1LwliJbcaKnDmts4bWu1kn--
