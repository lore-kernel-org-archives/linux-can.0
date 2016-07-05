From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based
 irq offloading
Date: Tue, 5 Jul 2016 08:19:31 +0200
Message-ID: <9e7e6562-3ed5-6807-a178-aa19595191a8@pengutronix.de>
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <3035212.Yo4Bos9bxC@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="ls03VaOuKowDGJOumPr3JqJir7UEghBaR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:38594 "EHLO
	metis.ext.4.pengutronix.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751492AbcGEGTn (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 5 Jul 2016 02:19:43 -0400
In-Reply-To: <3035212.Yo4Bos9bxC@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, david@protonic.nl

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ls03VaOuKowDGJOumPr3JqJir7UEghBaR
Content-Type: multipart/mixed; boundary="EOdfFj5hbLGwlEwPuHkwuAmxVB02fuOPh"
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: linux-can@vger.kernel.org, david@protonic.nl
Message-ID: <9e7e6562-3ed5-6807-a178-aa19595191a8@pengutronix.de>
Subject: Re: [PATCH v2 02/12] can: rx-offload: Add support for timestamp based
 irq offloading
References: <1467657137-18891-1-git-send-email-mkl@pengutronix.de>
 <1467657137-18891-3-git-send-email-mkl@pengutronix.de>
 <3035212.Yo4Bos9bxC@ws-stein>
In-Reply-To: <3035212.Yo4Bos9bxC@ws-stein>

--EOdfFj5hbLGwlEwPuHkwuAmxVB02fuOPh
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/05/2016 07:46 AM, Alexander Stein wrote:
> On Monday 04 July 2016 20:32:07, Marc Kleine-Budde wrote:
>> Some CAN controllers don't implement a FIFO in hardware, but fill thei=
r
>> mailboxes in a particular order (from lowest to highest or highest to
>> lowest). This makes problems to read the frames in the correct order f=
rom
>> the hardware, as new frames might be filled into just read (low) mailb=
oxes.
>> This gets worse, when following new frames are received into not read
>> (higher) mailboxes.
>>
>> On the bright side some these CAN controllers put a timestamp on each
>> received CAN frame. This patch adds support to offload CAN frames in
>> interrupt context, order them by timestamp and then transmitted in a N=
API
>> context.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>=20
> How is this supposed to work with CAN controllers without tmestamps, e.=
g.=20
> CCAN/DCAN? Do you need to set the timestamp manually using ktime_get() =
or=20
> similar when reading each mailbox? IMHO especially those controllers ar=
e prone=20
> to ordering issues under heavy load as the hardware doesn't ensure orde=
ring by=20
> itself and there is no hardware based timestamp.

The algorithm added in this patch only supports controllers that add
timestamps to the mailbox on reception in hardware (like flexcan, at91
and hecc). However the other algorithm we implemented didn't make use of
timestamps and targeted controllers that fill mailboxes in a particular
order. It can be ported to the current framework and the c_can/d_can
driver to it.

regards,
Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--EOdfFj5hbLGwlEwPuHkwuAmxVB02fuOPh--

--ls03VaOuKowDGJOumPr3JqJir7UEghBaR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJXe1FzAAoJED07qiWsqSVq8yEIALC63GhO+muatOLWOxP4fx5M
5hb0gxlXGb1Ffl7sd/po4KnU4oVgMHwvYCBt1a9oS6im7mwnI5jc2MTpbCm0nmtL
m175W9yWWvl6Fy9I9P6wCZkD9A40UASgt5moPc42bNuQsouEopwpw5NIQ2YfIEWZ
aUgLHSdCQTwMPYnX4TdrhPF5a3ppc6F+jobK6Jl7Ac6ukrUVkn871q7gVWjhdJr1
lX4iDGXVEtQXb5mNS53TdrFdLO46GwZr5pDN/RG91VMqsw06qoWiP1Gk5XE2puA2
//yXN9D/srAOaKiGSMcpNFehbTMfYOm8JNo3WtTtPewjPBN40mIMeIotOqfmBkE=
=eudZ
-----END PGP SIGNATURE-----

--ls03VaOuKowDGJOumPr3JqJir7UEghBaR--
