From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [Rfi] Cyclone V CAN errors when application pinned to CPU1
Date: Tue, 20 Oct 2015 09:37:41 +0200
Message-ID: <5625EF45.2000807@pengutronix.de>
References: <562155B7.7020504@vsis.cz> <20151020071807.GH20879@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9M1VVTNbjmS0TQhRJUJBWwT7F9tLClLmR"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.4.pengutronix.de ([92.198.50.35]:42337 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786AbbJTHhs (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 20 Oct 2015 03:37:48 -0400
In-Reply-To: <20151020071807.GH20879@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Robert Schwebel <r.schwebel@pengutronix.de>, Vlastimil Setka <setka@vsis.cz>
Cc: rfi@lists.rocketboards.org, linux-can <linux-can@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9M1VVTNbjmS0TQhRJUJBWwT7F9tLClLmR
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

CC +=3D linux-can

On 10/20/2015 09:18 AM, Robert Schwebel wrote:

> Adding Marc to Cc:.

tnx Robert.

> On Fri, Oct 16, 2015 at 09:53:27PM +0200, Vlastimil Setka wrote:
>> We discovered very weird behaviour of CAN controller in Cyclone V SoC
>> with Linux socketcan stack. The problem was first seen on 3.10-ltsi a
>> few months ago, and now again on 3.18 from altera github (with rt
>> preempt patch applied).
>=20
> Could you try if the issue happens with a recent mainline kernel as
> well? RT is available for 4.1, so that would be a good choice.

Which CAN driver are you using?

>> We have a linux application which sends data periodically (1 to 20 ms
>> period) out over the can0 socketcan interface. Sometimes the first
>> data byte in the CAN frame is zero on the wire, but non-zero in the
>> data sent! When running with this period, this happens at random
>> times, but during a few minutes it can be allways replicated.

How do you measure the CAN frames on the wire?

>> The problem only appears when the application is pinned to CPU1 by
>> linux process afinity mechanism. When pinned to default CPU0, there is=

>> no problem.
>>
>> Anyone seen this issue? Any idea how to debug it and what can be a
>> reason? What version (git repo / tag) of Linux should I use?
>>
>> We plan to do some in-deep evaluation and testing, but I want to share=

>> the experience now.

The TX functions is usually pretty straight forward. Copy all data bytes
into the hardware, write ID and DLC, then hit the send bit (or whatever
triggers the hardware to send the frame). Maybe there's some barrier
missing in this sequence? Where can I find your driver?

> Is your test program available somewhere?

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--9M1VVTNbjmS0TQhRJUJBWwT7F9tLClLmR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWJe9FAAoJEP5prqPJtc/HLboIALpUiKGOQkO0AO589y4tHinn
joNMei02iy9HImpXQGzzVePCd7pzTsrdntCy/27bY2GUFGeONCkjsxiHWhsNAr/4
2nskkXyjr5XU6k92zGf5pKX52gZKjc9wkd8KNBhIGtF/KB28aztQP5EeNhiuX7Ga
wEjqCXaf/gWOjTmrRb//TKwYzU3utRBxRQR1JurpwrZfVo2LhqdwixI+Vsyg4IMr
hYtR4NKSlS7QtF2xgVYRoRKgNU9ExUn7gWnlsl2CgnwAK+DQkVAF2m9f6fggXdnp
OUhxC9tgfp9aKy5iiLtRNWQA4lyzDmB3h5saast9DbJu+BVpvD3GM11maRrN9LE=
=MOPK
-----END PGP SIGNATURE-----

--9M1VVTNbjmS0TQhRJUJBWwT7F9tLClLmR--
