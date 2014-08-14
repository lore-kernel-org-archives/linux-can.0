From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 4/4] can: flexcan: Disable error irq when in error passive
Date: Thu, 14 Aug 2014 15:58:19 +0200
Message-ID: <53ECC07B.8030105@pengutronix.de>
References: <1407850987-26707-1-git-send-email-alexander.stein@systec-electronic.com> <1407850987-26707-4-git-send-email-alexander.stein@systec-electronic.com> <53EC9B17.80600@pengutronix.de> <2700138.iRYuM1TADC@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JnSHrFn6T824pEpLj6hawA089PxQQKjnn"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:39445 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755103AbaHNN63 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 14 Aug 2014 09:58:29 -0400
In-Reply-To: <2700138.iRYuM1TADC@ws-stein>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Stein <alexander.stein@systec-electronic.com>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JnSHrFn6T824pEpLj6hawA089PxQQKjnn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 08/14/2014 03:19 PM, Alexander Stein wrote:
> On Thursday 14 August 2014 13:18:47, Marc Kleine-Budde wrote:
>> On 08/12/2014 03:43 PM, Alexander Stein wrote:
>>> If the error irq is enabled and the hardware is trying to send a CAN
>>> message to an open bus it will receive a lot of acknowledge errors an=
d
>>> generating lots of interrupts. So error interrupts are disabled when
>>> entering error passive and reenable them when leaving error passive.
>>> We can only leave error passive by receiving CAN frames in which case=
 NAPI
>>> is scheduled anyway or by sending more CAN frames when send is possib=
le
>>> again. But with the transition of error counters from 96 to 95 the fl=
ags
>>> TX_WRN and RX_WRN are gone again, so we need to remember the flags st=
ate
>>> to detect a change there.
>>
>> There are use cases where the error interrupts even when in passive mo=
de
>> are essential. You have a use case, where you'd like to turn them off
>> completely. Have you had a look at the bus error limiting patches?
>=20
> Do you mean "[PATCH v7] flexcan: add err_irq handler for flexcan" from =
Zhao Qiang?

No, sorry I assumes you were following the discussion with Matthias
Klein and Sebastian Andrzej Siewior [1].

I was talking about the patch from
http://comments.gmane.org/gmane.linux.can/4070

The idea behind this series is to not enable the bus error interrupt
right after it has served, but after a configurable delay, e.g. 100ms.
Even with an open or otherwise faulty but, you then receive just 10
error frames per second.

Marc

[1] http://thread.gmane.org/gmane.linux.can/6271
[2] http://thread.gmane.org/gmane.linux.can/6280

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--JnSHrFn6T824pEpLj6hawA089PxQQKjnn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlPswHsACgkQjTAFq1RaXHOwDwCfTFLzlLH96D17XyMEaAu5hNwx
TSgAoIWOhJGUpQS+OjjTp5DJPc3vm3v6
=iSsV
-----END PGP SIGNATURE-----

--JnSHrFn6T824pEpLj6hawA089PxQQKjnn--
