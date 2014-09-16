From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: RFC: [PATCH v2] can: flexcan: Implement errata ERR005829
Date: Tue, 16 Sep 2014 13:48:27 +0200
Message-ID: <5418238B.6010600@pengutronix.de>
References: <1409755642-28233-1-git-send-email-david@protonic.nl>	<54081940.6060402@pengutronix.de> <20140904104440.5766d764@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="DlrViWUSCpJlmEnrGpTljDoQ0XRBLNIkX"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:52595 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413AbaIPLsd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 07:48:33 -0400
In-Reply-To: <20140904104440.5766d764@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DlrViWUSCpJlmEnrGpTljDoQ0XRBLNIkX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2014 10:44 AM, David Jander wrote:
>> Looks good. Can you please prepare a more detailed commit message.
>=20
> Ok, I will briefly describe the workaround. I first thought that mentio=
ning the
> errata number would be sufficient, since it is freely available documen=
tation
> from Freescale.
>=20
> Just in case you want to paste it into your version of the patch, here =
it goes:
>=20
> ERR005829: FlexCAN: FlexCAN does not transmit a message that is enabled=
 to be
> transmitted in a specific moment during the arbitration process.
>=20
> Workaround: The workaround consists of two extra steps after setting up=
 a
> message for transmission:
>=20
> Step 8:  Reserve the first valid mailbox as an inactive mailbox (CODE=3D=
0b1000).
> If RX FIFO is disabled, this mailbox must be message buffer 0. Otherwis=
e, the
> first valid mailbox can be found using the "RX FIFO filters" table in t=
he
> FlexCAN chapter of the chip reference manual.
>=20
> Step 9: Write twice INACTIVE code (0b1000) into the first valid mailbox=
=2E

Thanks, added the description to the patch.

>=20
>>>  drivers/net/can/flexcan.c | 10 +++++++++-
>>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>>> index 0bcbb96..d9d0ecb 100644
>>> --- a/drivers/net/can/flexcan.c
>>> +++ b/drivers/net/can/flexcan.c
>>> @@ -125,7 +125,9 @@
>>>  	 FLEXCAN_ESR_BOFF_INT | FLEXCAN_ESR_ERR_INT)
>>> =20
>>>  /* FLEXCAN interrupt flag register (IFLAG) bits */
>>> -#define FLEXCAN_TX_BUF_ID		8
>>> +/* Errata ERR005829 step7: Reserve first valid MB */
>>> +#define FLEXCAN_FIRST_VALID_MB		8
>>> +#define FLEXCAN_TX_BUF_ID		9
>>>  #define FLEXCAN_IFLAG_BUF(x)		BIT(x)
>>>  #define FLEXCAN_IFLAG_RX_FIFO_OVERFLOW	BIT(7)
>>>  #define FLEXCAN_IFLAG_RX_FIFO_WARN	BIT(6)
>>> @@ -428,6 +430,12 @@ static int flexcan_start_xmit(struct sk_buff *sk=
b,
>>> struct net_device *dev) flexcan_write(can_id,
>>> &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_id); flexcan_write(ctrl,
>>> &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);=20
>>
>> However, I don't want to write unconditionally two times here, so I've=

>> added a runtime decision with a quirk for this. I'll send an updated p=
atch.
>=20
> Please note that if the silicon bug didn't exist, none of the two write=
s would
> be necessary.
> Once you create a quirk for this, how are we supposed to know which ver=
sions
> need this quirk, and which don't? Can we trust the existence of erratas=
 for
> the different i.MX Soc's, and should we just go and check them all?

I had a patch with the quirk, but I removed it, as you suggested, just
in case.

Marc
--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--DlrViWUSCpJlmEnrGpTljDoQ0XRBLNIkX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQYI4sACgkQjTAFq1RaXHNlZwCePa4+b/5LBauvjczrH4tMxUrj
kZgAoIq4j3K5UizAIDCrRcgjlFHQMenO
=Hm2U
-----END PGP SIGNATURE-----

--DlrViWUSCpJlmEnrGpTljDoQ0XRBLNIkX--
