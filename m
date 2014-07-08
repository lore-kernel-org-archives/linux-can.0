From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/1] can: m_can: add Bosch M_CAN controller support
Date: Tue, 08 Jul 2014 13:20:18 +0200
Message-ID: <53BBD3F2.5010806@pengutronix.de>
References: <1404474812-16855-1-git-send-email-b29396@freescale.com> <53B69C55.8010901@pengutronix.de> <20140707071040.GA18505@shlinux1.ap.freescale.net> <53BA7543.70901@pengutronix.de> <20140708103009.GA21754@shlinux1.ap.freescale.net> <53BBCAE5.7040404@pengutronix.de> <20140708110820.GC21754@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="422RRUxJWjlCUIBkNkMgdjc4dsil1M4D9"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:48810 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbaGHLU3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 8 Jul 2014 07:20:29 -0400
In-Reply-To: <20140708110820.GC21754@shlinux1.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--422RRUxJWjlCUIBkNkMgdjc4dsil1M4D9
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/08/2014 01:08 PM, Dong Aisheng wrote:
> On Tue, Jul 08, 2014 at 12:41:41PM +0200, Marc Kleine-Budde wrote:
>> On 07/08/2014 12:30 PM, Dong Aisheng wrote:
>>>> Regarding the mram and the offsets:
>>>>
>>>>> 	fifo_addr =3D priv->mram_base + priv->rxf0_off + fgi * RXF0_ELEMEN=
T_SIZE;
>>>>> 	fifo_addr =3D priv->mram_base + priv->mram_off + priv->txb_off;
>>>>
>>>> Why is rxf0_off used without the mram_off and txb_off with the mram_=
off?
>>>> Can you please test your driver with a mram offset !=3D in your DT.
>>>>
>>>> If I understand the code in m_can_of_parse_mram() correctly the
>>>> individual *_off are already offsets to the *mram_base, so mram_off
>>>> should not be used within the driver.
>>>
>>> Good catch!
>>> You're right! I aslo found this recently!
>>> txb_off already includes the mram_off so should not plus mram_off aga=
in.
>>> The former test did not find it because it's still not exceed the 16K=
 ram
>>> size for m_can0. But m_can1 has such issue.
>>>
>>>> I even think mram_off should be removed from the priv.
>>>
>>> Right, i also think so.
>>>
>>> It is used for debug information formerly that we need mram_off
>>> to calculate each element address in the fifo.
>>>
>>> By removing mram_off, i'm going to change the debug information to:
>>> dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 %x %=
d rxf1 %x %d rxb %x %d txe %x %d txb %x %d\n",
>>> 	priv->mram_base, priv->sidf_off, priv->sidf_elems,
>>> 	priv->xidf_off, priv->xidf_elems, priv->rxf0_off,
>>> 	priv->rxf0_elems, priv->rxf1_off, priv->rxf1_elems,
>>> 	priv->rxb_off, priv->rxb_elems, priv->txe_off,
>>> 	priv->txe_elems, priv->txb_off, priv->txb_elems);
>>>
>>> The annoying thing is the line has to be a much bigger one to avoid
>>> checkpatch warning of "WARNING: quoted string split across lines".
>>>
>>> What's your suggestion for such issue?
>>> Keeping the big line or split into two lines and leave checkpatch war=
ning there?
>>
>> The idea behind the warning is, that you can grep for error messages
>> better, as normal grep wouldn't find an error string which spans two
>> lines. So make it a long line.
>>
>>>> Do the *_off and *_elems fit into a u8 or u16? If
>>>> so it makes sense to convert the priv accordingly.
>>>>
>>>
>>> Yes, *_off fit into u16 since MRAM has a maximum of 4352 words(17K).
>>> And *_elems fit into u8 since the max number is 128.
>>> I will change them accordingly.
>>>
>>>> What about putting the offset and the number of elements into a stru=
ct
>>>> and make use an array for rxf{0,1}?
>>>>
>>>
>>> You mean something like below?
>>> struct mram_cfg {
>>> 	u16 off;
>>> 	u8  elements;
>>> };
>>>
>>> struct m_can_priv {
>>> 	........
>>>
>>>         struct mram_cfg sidf;
>>>         struct mram_cfg xidf;
>>>         struct mram_cfg rxf0;
>>>         struct mram_cfg rxf1;
>>
>> struct mram_cfg rxf[2];
>>
>=20
> It does not help too much and a bit strange for only make
> rxf0/rxf1 into array,
>=20
> How about making them all:
> enum m_can_mram_cfg {
> 	SIDF =3D 0,
> 	XIDF,
> 	RXF0,
> 	RXF1,
> 	RXB,
> 	TXE,
> 	TXB,
> 	CFG_NUM,
> };
>=20
> struct m_can_priv {
> 	........
> 	struct mram_cfg mcfg[CFG_NUM];
> };
>=20
> Then in code:
>=20
> priv->cfg[SIDF].off =3D=20
> priv->cfg[SIDF].elements =3D=20
>=20
> But it could make code become much longer...

I like the idea, but can you add a common prefix to the enums. Though
makes the code even longer :)

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--422RRUxJWjlCUIBkNkMgdjc4dsil1M4D9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO70/IACgkQjTAFq1RaXHMGgQCeLObzAjymwWTY2BVeNVcEeKvX
NwMAn31JHUzuMVLQvDyJlygYU1UcCQS/
=GyEb
-----END PGP SIGNATURE-----

--422RRUxJWjlCUIBkNkMgdjc4dsil1M4D9--
