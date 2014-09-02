From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH 1/3] can: flexcan.c: Correctly initialize mailboxes
Date: Tue, 02 Sep 2014 13:38:37 +0200
Message-ID: <5405AC3D.5040508@pengutronix.de>
References: <1409133487-23367-1-git-send-email-david@protonic.nl>	<1409133487-23367-2-git-send-email-david@protonic.nl>	<54059ADC.60309@pengutronix.de>	<20140902123725.01808f36@archvile>	<5405A31E.1060403@pengutronix.de> <20140902133255.42a73441@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4pVgGHrA6djmCKtc43O1NUbiBBQfxsM4u"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43808 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752895AbaIBLin (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 2 Sep 2014 07:38:43 -0400
In-Reply-To: <20140902133255.42a73441@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: wg@grandegger.com, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4pVgGHrA6djmCKtc43O1NUbiBBQfxsM4u
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/02/2014 01:32 PM, David Jander wrote:
> On Tue, 02 Sep 2014 12:59:42 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
>> On 09/02/2014 12:37 PM, David Jander wrote:
>>> On Tue, 02 Sep 2014 12:24:28 +0200
>>> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>>>
>>>> On 08/27/2014 11:58 AM, David Jander wrote:
>>>>> Apparently mailboxes may contain random data at startup, causing so=
me of
>>>>> them being prepared for message reception. This causes overruns bei=
ng
>>>>> missed or even confusing the IRQ check for trasmitted messages,
>>>>> increasing the transmit counter instead of the error counter.
>>>>>
>>>>> Signed-off-by: David Jander <david@protonic.nl>
>>>>
>>>> Before patch
>>>>
>>>> 0d1862e can: flexcan: fix flexcan_chip_start() on imx6
>>>>
>>>> there was a loop clearing the whole cantxfg register space. But this=

>>>> turned out to be bogus, as message buffers 1...7 are reserved by the=

>>>> FIFO engine and we're not allowed to tough them. This lead to some k=
ind
>>>> of abort on imx6.
>>>>
>>>> You may need this patch once you don't make use of the FIFO engine a=
ny
>>>> more.
>>>
>>> You will need this patch in either case, but indeed, if you use the F=
IFO,
>>> you should skip the MB's that are shadowed by the FIFO.
>>
>> ACK
>>
>>> If you don't clear the rest of the MB's they may still contain random=
 data
>>> and the problem remains.
>>> IMHO 0d1862e is wrong, since buffers are not in reset default values.=

>>> There is no indication of that in the reference manual, and I have
>>> observed that they are indeed not cleared after reset.
>>
>> Yes, 0d1862e was not complete, the initialisation was fixes with:
>>
>> d5a7b40 can: flexcan: flexcan_chip_start: fix regression,
>>                        mark one MB for TX and abort pending TX
>>
>> Which sets FLEXCAN_MCR_MAXMB to 8, which is the only mailbox used for =
tx
>> and the code of the tx mailbox is set to 0x4 =3D=3D tx, inactive.
>=20
> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
> index 3f21142..f028c5d 100644
> --- a/drivers/net/can/flexcan.c
> +++ b/drivers/net/can/flexcan.c
> @@ -62,7 +62,7 @@
>  #define FLEXCAN_MCR_BCC			BIT(16)
>  #define FLEXCAN_MCR_LPRIO_EN		BIT(13)
>  #define FLEXCAN_MCR_AEN			BIT(12)
> -#define FLEXCAN_MCR_MAXMB(x)		((x) & 0xf)
> +#define FLEXCAN_MCR_MAXMB(x)		((x) & 0x1f)
>  #define FLEXCAN_MCR_IDAM_A		(0 << 8)
>  #define FLEXCAN_MCR_IDAM_B		(1 << 8)
>  #define FLEXCAN_MCR_IDAM_C		(2 << 8)
> @@ -735,9 +735,11 @@ static int flexcan_chip_start(struct net_device *d=
ev)
>  	 *
>  	 */
>  	reg_mcr =3D flexcan_read(&regs->mcr);
> +	reg_mcr &=3D ~FLEXCAN_MCR_MAXMB(0xff);
>  	reg_mcr |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |
>  		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
> -		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS;
> +		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
> +		FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
>  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
>  	flexcan_write(reg_mcr, &regs->mcr);
> =20
> Eh! This looks wrong! The MAXMB field is 7 bits wide according to the
> reference manual (bits 0-6)... but the reset default value is supposed =
to be

=2E..according to the imx6 reference manual. The size of the MAXMB field
depends on the actual IP version.

> 0x0f, so the mask is still enough to clear the reset default.
> What I don't understand is why the CAN controller is still able to put
> messages into MB's after the FIFO is full. At least that is what I obse=
rved.

It says to in the imx6 manual, but not in the older ones (see other
mail, that I'm still writing).

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--4pVgGHrA6djmCKtc43O1NUbiBBQfxsM4u
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQFrD0ACgkQjTAFq1RaXHMWegCdHioW2N/CbRYjljGhmPC1hk9g
oMYAoIXk+bCrKdZ2JPE4cuOlTzDej030
=E8Xt
-----END PGP SIGNATURE-----

--4pVgGHrA6djmCKtc43O1NUbiBBQfxsM4u--
