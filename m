From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/5] can: kvaser_usb: Avoid double free on URB
 submission failures
Date: Mon, 09 Mar 2015 13:56:28 +0100
Message-ID: <54FD987C.2070804@pengutronix.de>
References: <20150226152011.GA6075@linux> <54F6CD41.8050703@pengutronix.de> <20150309123254.GA18661@linux>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="T90I2mCaoVOnodAOU5pk3Qw48ga0pRFNL"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:44734 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753325AbbCIM4m (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 9 Mar 2015 08:56:42 -0400
In-Reply-To: <20150309123254.GA18661@linux>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: Olivier Sobrie <olivier@sobrie.be>, Oliver Hartkopp <socketcan@hartkopp.net>, Wolfgang Grandegger <wg@grandegger.com>, Andri Yngvason <andri.yngvason@marel.com>, Linux-CAN <linux-can@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T90I2mCaoVOnodAOU5pk3Qw48ga0pRFNL
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/09/2015 01:32 PM, Ahmed S. Darwish wrote:
> (Sorry for the late reply as I was out of town!)

np :)

> On Wed, Mar 04, 2015 at 10:15:45AM +0100, Marc Kleine-Budde wrote:
>> On 02/26/2015 04:20 PM, Ahmed S. Darwish wrote:
>>> From: Ahmed S. Darwish <ahmed.darwish@valeo.com>
>>>
>>> Upon a URB submission failure, the driver calls usb_free_urb()
>>> but then manually frees the URB buffer by itself.  Meanwhile
>>> usb_free_urb() has alredy freed out that transfer buffer since
>>> we're the only code path holding a reference to this URB.
>>>
>>> Remove two of such invalid manual free().
>>>
>>> Signed-off-by: Ahmed S. Darwish <ahmed.darwish@valeo.com>
>>
>> Applied 1+2 and added stable on Cc. Can you please shuffle the remaini=
ng
>> patches, so that patch 5 comes first, then 4 and 3 as the last patch. =
As
>> 5 is a bugfix it should go into stable, while 3 isn't.
>>
>> You can base your series on the can/testing branch.

> Did not care much about the bugfixes order this time as the patches
> themselves will not apply cleanly (or at all) to -stable due to the
> addition of UsbCAN-II code, which all -stable kernels do not have.
> Thus I guess I'll need to submit a different patch series for -stable
> with patches 1, 2, and 5 -- rebased.

Submitting patches ported to -stable would be a second step. You don't
have to, but I'd appreciate it.

> Nonetheless, you're correct that having the bugfixes (1,2,5), then the
> optimization (4), then the janitorial fix (3) is the logical order for
> history & bisection sake. So.. I'll re-order the patches, individually
> test with the new order, and re-submit over can/testing.

Ack, or bugfix, janitorial then optimization. Please use
linux-can-fixes-for-4.0-20150309 (which include 1 and 2) as your base.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--T90I2mCaoVOnodAOU5pk3Qw48ga0pRFNL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJU/ZiBAAoJECte4hHFiupUn5MP/ieZ9upBUHB+dsAZgCmwdUf2
SuzG874BuyTIBFg0fHT0/dk2mb5PZQMo+emVyNyXPODgQoAzYQDsqQL+xPM/ERDX
rFpr+abYl64DOm1Lo5z8+MeyIinNGxPAUJyVFp5Hk/gHoGd6xsPEFlv6yFX7BcXc
ecSR7mJ8iHH9ilDqJz/FrXprp4P5W6e0v4l2i12IcTgN43QsfqsKT2nthPw5rkzI
/poCFd4U326slFqvN4gQBYKtfDD4wwCFO2n5C36y43/uBX8h1+FsP7Nbv24a8OId
e5hJURJlpB3vZG5iZ4B/9g7BTmGG9/I/MrlMtoVzM9oUHCdV6xmU8musaaRIMqcV
Wi3GBZcbOj898x+O7lEWEEM6lLD+fDLtxxZdZmEtHzy1fn5ke7KMrPoMCYxx8X/v
T7ITc/+qSiW3kfXJZ32RDdBKk+kv9cuqHSCrbBUCaLtirehIkpkx7bIx6GEI39uG
fJJvosl6SLZWsn+D4/DAyvGz05N+xZVT/9iNeg8P33bz4pDq7v5KgzidCTo+ayRJ
BuCcImppzvvRF3FP/qhAMCb0NLicbrryfz3hGPCcUS96HXZ/0m/AIrPWG2P5899L
sFPaG5NQTpqXyAJ3xQ1nHb9ozDOKr7aK1gbJTFruGQwVHA3eg0lltuMKLDRXvYgF
MkhSYKRRg2QOlGPrXJ52
=PHdl
-----END PGP SIGNATURE-----

--T90I2mCaoVOnodAOU5pk3Qw48ga0pRFNL--
