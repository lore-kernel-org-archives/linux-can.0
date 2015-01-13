From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] can/peak_usb: add support for PEAK new CANFD USB adapters
Date: Tue, 13 Jan 2015 14:32:55 +0100
Message-ID: <54B51E87.30308@pengutronix.de>
References: <1420538446-8336-1-git-send-email-s.grosjean@peak-system.com> <54AD66C5.10908@pengutronix.de> <54B51B2C.3080404@peak-system.com> <54B51DB5.2030707@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qU7h7Mtgtau87sqdEPBl0TqGH7pFkJgH0"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47474 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751220AbbAMNc7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 13 Jan 2015 08:32:59 -0500
In-Reply-To: <54B51DB5.2030707@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>, linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qU7h7Mtgtau87sqdEPBl0TqGH7pFkJgH0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 01/13/2015 02:29 PM, Marc Kleine-Budde wrote:
> On 01/13/2015 02:18 PM, Stephane Grosjean wrote:
>> Hi Marc,
>>
>> Le 07/01/2015 18:03, Marc Kleine-Budde a =C3=A9crit :
>>> On 01/06/2015 11:00 AM, Stephane Grosjean wrote:
>>>   @@ -750,9 +795,10 @@ static int peak_usb_create_dev(struct
>>> peak_usb_adapter *peak_usb_adapter,
>>>       dev->can.clock =3D peak_usb_adapter->clock;
>>>       dev->can.bittiming_const =3D &peak_usb_adapter->bittiming_const=
;
>>>       dev->can.do_set_bittiming =3D peak_usb_set_bittiming;
>>> +    dev->can.data_bittiming_const =3D
>>> &peak_usb_adapter->data_bittiming_const;
>>> +    dev->can.do_set_data_bittiming =3D peak_usb_set_data_bittiming;
>>>       dev->can.do_set_mode =3D peak_usb_set_mode;
>>> -    dev->can.ctrlmode_supported =3D CAN_CTRLMODE_3_SAMPLES |
>>> -                      CAN_CTRLMODE_LISTENONLY;
>>> +    dev->can.ctrlmode_supported =3D peak_usb_adapter->ctrlmode_suppo=
rted;
>>> All ctrlmode_supported can go into a seperate patch.
>>
>> I'll try but can you please explain why?

BTW: you can split a patch into multiple patches with git quite easy:

# move branch head one patch backwards, working copy stays unmodified:
git reset HEAD^

# for each hunk git will ask you if you want to stage it.
# you can even split a hunk.
git add -p

or use git gui instead of git add -p.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--qU7h7Mtgtau87sqdEPBl0TqGH7pFkJgH0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUtR6HAAoJECte4hHFiupUqBUP/R/dAIt1YPwUg7Gu++zkhlmx
Avw8yBwfWIGA8mfag2tPz5t+4EGpDHgGKypi1jMBpnpheDaoiuYIO4GvkNrgxpgB
EsVbScEpNoAPj+khMUQpslRvh4k/hjKx1QBBU58QCxIa5p0ppWgkS0AjY33/eZbn
uThQthfDpAap58xDezuFg3HnadYpgGXdvi6gX3d1SJf+wglDACWR4gORVlF732Xo
/9waRMA8O3cdZf1sdI73epgNdvJ52mubHJFSAWWewMSqcyid4KAXpR1T8fPb0XzC
j4m4Y1ykoRmG0O1HJFaGhvhyAxg2lojUOCvGH+DFsLUd52++kVOzlqs+4zpSOaUs
2G4dOsKsu30IkMs+tke7B6ps3e5XupUVrczDim/TdqX5jAu+qBiqEwDn8f4ep920
/BrWK747T4QOjpebHSDqf+G+4YWeRjf3b9twe2W3oADZH4hXSphvSUzGKzlN0IVF
uazcVojITMJSFgKzWwtBq+RciH8pTipwx2HeXlA0g4QW5OLOYddNhfqxIAZS2pAR
AZOHcuG68bs1CKoJCmU8x+o1OhvTPvyaenkD35Q0rAz2po/eMe0UVDtCB8lmbWTh
mEPQ65XIrXGlcdl3fxbHVgSKjUPvxF9GgwZFPSEX8QP/0q4dcFxzD3uSCE0cRY1M
nrblcq+TXjXDlUelRoIs
=05MP
-----END PGP SIGNATURE-----

--qU7h7Mtgtau87sqdEPBl0TqGH7pFkJgH0--
