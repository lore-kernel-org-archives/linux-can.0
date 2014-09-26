From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v4] can: flexcan: Re-write receive path to use MB queue
 instead of FIFO
Date: Fri, 26 Sep 2014 11:35:47 +0200
Message-ID: <54253373.7000201@pengutronix.de>
References: <1411048090-16837-1-git-send-email-david@protonic.nl>	<54216E5F.2010804@pengutronix.de> <20140923155319.691b2241@archvile>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="F763gaBgNXD2MDRVMiKwc1caCp75N91ef"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46816 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753122AbaIZJf6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 26 Sep 2014 05:35:58 -0400
In-Reply-To: <20140923155319.691b2241@archvile>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: David Jander <david@protonic.nl>
Cc: Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--F763gaBgNXD2MDRVMiKwc1caCp75N91ef
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 09/23/2014 03:53 PM, David Jander wrote:

>> On 09/18/2014 03:48 PM, David Jander wrote:
>>> The FlexCAN controller has a RX FIFO that is only 6 messages deep, an=
d a
>>> mailbox space capable of holding up to 63 messages.
>>> This space was largely unused, limiting the permissible latency from
>>> interrupt to NAPI to only 6 messages. This patch uses all available M=
Bs
>>> for message reception and frees the MBs in the IRQ handler to greatly=

>>> decrease the likelihood of receive overruns.
>>>
>>> Signed-off-by: David Jander <david@protonic.nl>
>>
>> I think we can improve the algorithm a bit.
>>
>> I see a problem when you receive 4 CAN frames:
>>
>> 0-1-2-3
>>
>> then the irq handler starts, 0 gets processed and is empty (E)
>>
>> E-1-2-3
>=20
> No. It will not be empty. It will be marked inactive immediately in
> flexcan_copy_one_rxmb().
>=20
>> while in the interrupt handler another two frames come in:
>>
>> 4-1-2-3-5
>=20
> That can't happen ;-)
>=20
>> I suggest add a variable to the priv which indicates the next MB to re=
ad
>> from. Further, don't clear the mailbox direclty after it's been read,
>> wait until a certain amount of read mailboxes accumulate, .e.g. when t=
he
>> rx_next point to 32. I have a work-in-progress code which to abstract
>=20
> More or less exactly what I do. Please read the comment to flexcan_copy=
_rxmbs()

Yes you're right, I missed the:

> 	if (i >=3D 32) {
> 		/* Re-enable all disabled MBs */

in the code.

[...]

>>> @@ -741,10 +743,16 @@ static int flexcan_read_frame(struct net_device=
 *dev)
>>>  static int flexcan_poll(struct napi_struct *napi, int quota)
>>>  {
>>>  	struct net_device *dev =3D napi->dev;
>>> -	const struct flexcan_priv *priv =3D netdev_priv(dev);
>>> +	struct flexcan_priv *priv =3D netdev_priv(dev);
>>>  	struct flexcan_regs __iomem *regs =3D priv->base;
>>> -	u32 reg_iflag1, reg_esr;
>>> +	u32 reg_esr;
>>>  	int work_done =3D 0;
>>> +	int n;
>>> +	int ret;
>>> +
>>> +	/* disable RX IRQs */
>>> +	flexcan_write((1 << FLEXCAN_TX_BUF_ID), &regs->imask1);
>>> +	flexcan_write(0, &regs->imask2);
>>
>> Please use defines here. BTW: the RX IRQ has to disabled in the IRQ ha=
ndler.
>=20
> Ok, will use #defines.... but why should I disable interrupts in the IR=
Q
> handler? I am copying all mailboxes in the IRQ, so no need to disable
> interrupts there...
> What I do here is avoid the IRQ from messing with my copy while pushing=
 it up
> NAPI.

As you don't access the hardware in the NAPI handler, why do you disable
the interrupts? AFAIK there is no guarantee that the interrupt handler
is not running on a different CPU when you enter the NAPI handler. You
have to lock the shared resource rx_idx.

I suggest to turn cantxfg_copy[] into a cyclic buffer, with a head and a
tail pointer. This way you can access them lockless.
>=20
>>> =20
>>>  	/*
>>>  	 * The error bits are cleared on read,
>>> @@ -755,12 +763,13 @@ static int flexcan_poll(struct napi_struct *nap=
i,
>>> int quota) /* handle state changes */
>>>  	work_done +=3D flexcan_poll_state(dev, reg_esr);
>>> =20
>>> -	/* handle RX-FIFO */
>>> -	reg_iflag1 =3D flexcan_read(&regs->iflag1);
>>> -	while (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE &&
>>> -	       work_done < quota) {
>>> -		work_done +=3D flexcan_read_frame(dev);
>>> -		reg_iflag1 =3D flexcan_read(&regs->iflag1);
>>> +	/* handle mailboxes */
>>> +	for (n =3D 0; (n < ARRAY_SIZE(priv->cantxfg_copy)) &&
>>> +			(work_done < quota); n++) {
>>> +		ret =3D flexcan_read_frame(dev, n);
>>> +		if (!ret)
>>> +			break;
>>> +		work_done +=3D ret;
>>>  	}
>>> =20
>>>  	/* report bus errors */
>>> @@ -769,24 +778,157 @@ static int flexcan_poll(struct napi_struct *na=
pi,
>>> int quota)=20
>>>  	if (work_done < quota) {
>>>  		napi_complete(napi);
>>> -		/* enable IRQs */
>>> -		flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
>>> -		flexcan_write(priv->reg_ctrl_default, &regs->ctrl);
>>> +		priv->rx_idx =3D 0;
>>> +
>>> +		/* enable RX IRQs */
>>> +		flexcan_write(FLEXCAN_IFLAG1_DEFAULT, &regs->imask1);
>>> +		flexcan_write(FLEXCAN_IFLAG2_DEFAULT, &regs->imask2);
>>>  	}
>>> =20
>>>  	return work_done;
>>>  }
>>> =20
>>> +static u32 flexcan_copy_one_rxmb(struct flexcan_priv *priv, int i)
>>> +{
>>> +	struct flexcan_regs __iomem *regs =3D priv->base;
>>> +	struct flexcan_mb __iomem *mb;
>>> +	struct flexcan_mb *dst;
>>> +	u32 reg_ctrl;
>>> +	u32 code;
>>> +
>>> +	mb =3D &regs->cantxfg[i];
>>> +	dst =3D &priv->cantxfg_copy[priv->rx_idx];
>>> +	reg_ctrl =3D flexcan_read(&mb->can_ctrl);
>>> +	code =3D (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT=
;
>>> +
>>> +	while (code & 1) {
>>> +		/* MB busy, shouldn't take long */
>>> +		reg_ctrl =3D flexcan_read(&mb->can_ctrl);
>>> +		code =3D (reg_ctrl & FLEXCAN_MB_CODE_MASK) >>
>>> FLEXCAN_MB_CODE_SHIFT;
>>> +	}
>>> +
>>> +	/* Copy contents */
>>> +	dst->can_ctrl =3D reg_ctrl;
>>> +	dst->can_id =3D flexcan_read(&mb->can_id);
>>> +	dst->data[0] =3D flexcan_read(&mb->data[0]);
>>> +	dst->data[1] =3D flexcan_read(&mb->data[1]);
>>> +
>>> +	/* If it's FULL or OVERRUN, clear the interrupt flag and lock MB
>>> */
>>> +	if ((code =3D=3D 0x2) || (code =3D=3D 0x6)) {
>>> +		if (i < 32)
>>> +			flexcan_write(BIT(i), &regs->iflag1);
>>> +		else
>>> +			flexcan_write(BIT(i - 32), &regs->iflag2);
>>
>> what about chaging the regs struct? Make it an ifalgs[2] array and you=

>> can use the 5th bit as the array index.
>=20
> Hmmm.... sounds like a good idea. Will try.
>=20
>>> +		flexcan_write(FLEXCAN_MB_CNT_CODE(0x0), &mb->can_ctrl);
>>> +		if ((code =3D=3D 0x6) || (priv->rx_idx =3D=3D
>>> +				(ARRAY_SIZE(priv->cantxfg_copy) - 1))) {
>>> +			/* This MB was overrun, we lost data */
>>> +			priv->dev->stats.rx_over_errors++;
>>> +			priv->dev->stats.rx_errors++;
>>> +		}
>>> +		if (priv->rx_idx < (ARRAY_SIZE(priv->cantxfg_copy) - 1))
>>> +			priv->rx_idx++;
>>
>> Can you move the overflow handling into the poll handler
>=20
> Is that necessary? This is the (only) place where I can detect overflow=
s, so
> why complicate the stats code by setting some temporary counter and the=
n
> increase the stats in the poll handler, when I can do it right here? Or=
 is it
> "wrong" to this from IRQ?

You can move the whole evaluating of "code" into NAPI handler, as you
access code in the NAPI handler anyways. It's not wrong to do this in
the IRQ handler, but if you optimize for speed ... :)

>=20
>>> +	}
>>> +
>>> +	return code;
>>> +}
>>> +
>>> +static void flexcan_unlock_if_locked(struct flexcan_priv *priv, int =
i)
>>
>> What about calling it call it flexcan_mb_unlock(), the if locked is an=

>> optimisation :)
>=20
> Well, if you prefer shorter names.... somehow I just felt like underlin=
ing the
> fact that this code should not just blindly write code 0x4 to the MB...=
 that
> would create a race.... so no, it is not just an optimization strictly
> speaking.

Okay.

>=20
>>> +{
>>> +	struct flexcan_regs __iomem *regs =3D priv->base;
>>> +	struct flexcan_mb __iomem *mb;
>>> +	u32 reg_ctrl;
>>> +	u32 code;
>>> +
>>> +	mb =3D &regs->cantxfg[i];
>>> +	reg_ctrl =3D flexcan_read(&mb->can_ctrl);
>>> +	code =3D (reg_ctrl & FLEXCAN_MB_CODE_MASK) >> FLEXCAN_MB_CODE_SHIFT=
;
>>> +	if (!code)
>>> +		flexcan_write(FLEXCAN_MB_CNT_CODE(0x4), &mb->can_ctrl);
>>> +}
>>> +
>>> +/*
>>> + * flexcan_copy_rxmbs
>>> + *
>>> + * This function is called from interrupt and needs to make a safe c=
opy
>>> + * of the MB area to offload the chip immediately to avoid loosing
>>> + * messages due to latency.
>>> + * To avoid loosing messages due to race-conditions while reading th=
e
>>> MB's,
>>> + * we need to make use of the locking mechanism of FlexCAN. Unfortun=
ately,
>>> + * in this mode, automatic locking applies _only_ to MBs that are _n=
ot_
>>> EMPTY.
>>> + * This means we could identify a MB as EMPTY while it is about to g=
et
>>> filled.
>>> + * To avoid this situation from disturbing our queue ordering, we do=
 the
>>> + * following:
>>> + * We split the MB area into two halves:
>>> + * The lower 32 (-2 due to one TX-MB and errata ERR005829) and the u=
pper
>>> 32.
>>> + * We start with all MBs in EMPTY state and all filters disabled (do=
n't
>>> care).
>>> + * FlexCAN will start filling from the lowest MB. Once this function=
 is
>>> called,
>>> + * we copy and disable in an atomic operation all FULL MBs. The firs=
t
>>> EMPTY one
>>> + * we encounter may be about to get filled so we stop there. Next ti=
me
>>> FlexCAN
>>> + * will have filled more MBs. Once there are no EMPTY MBs in the low=
er
>>> half, we
>>> + * EMPTY all FULL or locked MBs again.
>>> + * Next time we have the following situation:
>>> + * If there is a FULL MB in the upper half, it is because it was abo=
ut to
>>> get
>>> + * filled when we scanned last time, or got filled just before empty=
ing
>>> the
>>> + * lowest MB, so this will be the first MB we need to copy now. If t=
here
>>> are
>>> + * no EMPTY MBs in the lower half at this time, it means we cannot
>>> guarantee
>>> + * ordering anymore. It also means latency exceeded 30 messages.
>>> + */
>>
>> I'm not sure
>=20
> Can you be a little bit more specific about what exactly you are not su=
re?

Doh! This were my thoughts about the algorithm in general, which I
though have moved *completely* to the top of that mail ;)

>>> +static void flexcan_copy_rxmbs(struct flexcan_priv *priv, u32 iflag1=
, u32
>>> iflag2) +{
>>> +	struct flexcan_regs __iomem *regs =3D priv->base;
>>> +	int i;
>>> +
>>> +	if (priv->second_first) {
>>> +		/* Begin with second half */
>>> +		for(i =3D 32; i < 64; i++) {
>>> +			flexcan_copy_one_rxmb(priv, i);
>>> +			flexcan_unlock_if_locked(priv, i);
>>> +		}
>>> +	}
>>> +
>>> +	/* Copy and disable FULL MBs */
>>> +	for(i =3D 1; i < 64; i++) {
>>> +		if (i =3D=3D FLEXCAN_TX_BUF_ID)
>>> +			continue;
>>> +		if (flexcan_copy_one_rxmb(priv, i) =3D=3D 0x4)
>>
>> Typical linux coding style is to avoid the evaluation of a function's
>> return value directly in an if().
>>
>> ret =3D foo();
>> if (ret) {
>> }
>=20
> Ok, will fix that.
>=20
>>> +			break;
>>> +	}
>>> +
>>> +	if ((i >=3D 32) && priv->second_first)
>>> +		netdev_warn(priv->dev, "RX order cannot be guaranteed.
>>> count=3D%d\n", i); +
>>> +	priv->second_first =3D 0;
>>> +
>>> +	/* No EMPTY MB in first half? */
>>> +	if (i >=3D 32) {
>>> +		/* Re-enable all disabled MBs */
>>> +		for(i =3D 1; i < 64; i++) {
>>> +			if (i =3D=3D FLEXCAN_TX_BUF_ID)
>>> +				continue;
>>
>> Please start your loop at a sensible value to avoid checking for
>> FLEXCAN_TX_BUF_ID.
>=20
> Hmmm... I wanted to keep the value of FLEXCAN_TX_BUF_ID independent fro=
m the
> code, as it was already like that. Theoretically FLEXCAN_TX_BUF_ID coul=
d be
> any value. I also see now, that the loop should strictly speaking, star=
t at
> (FLEXCAN_TX_BUF_RESERVED + 1) also....

Please add a define specifying the beginning of the RX mailboxes, for
now this could be FLEXCAN_TX_BUF_ID + 1

> How can I not do this check and at the same time be sure the loop catch=
es all
> the valid MB's, even if someone decides to change FLEXCAN_TX_BUF_ID?

You can add a compile time check, but if someone changes some internal
values, she/he is in her/his own path anyways.

>=20
>>> +			flexcan_unlock_if_locked(priv, i);
>>> +		}
>>> +
>>> +		/* Next time we need to check the second half first */
>>> +		priv->second_first =3D 1;
>>> +	}
>>> +
>>> +	/* Unlock the last locked MB if any */
>>> +	flexcan_read(&regs->timer);
>>> +}
>>> +
>>>  static irqreturn_t flexcan_irq(int irq, void *dev_id)
>>>  {
>>>  	struct net_device *dev =3D dev_id;
>>>  	struct net_device_stats *stats =3D &dev->stats;
>>>  	struct flexcan_priv *priv =3D netdev_priv(dev);
>>>  	struct flexcan_regs __iomem *regs =3D priv->base;
>>> -	u32 reg_iflag1, reg_esr;
>>> +	u32 reg_iflag1, reg_iflag2, reg_esr;
>>> =20
>>>  	reg_iflag1 =3D flexcan_read(&regs->iflag1);
>>> +	reg_iflag2 =3D flexcan_read(&regs->iflag2);
>>>  	reg_esr =3D flexcan_read(&regs->esr);
>>> +
>>>  	/* ACK all bus error and state change IRQ sources */
>>>  	if (reg_esr & FLEXCAN_ESR_ALL_INT)
>>>  		flexcan_write(reg_esr & FLEXCAN_ESR_ALL_INT, &regs->esr);
>>> @@ -797,7 +939,7 @@ static irqreturn_t flexcan_irq(int irq, void *dev=
_id)
>>>  	 * - state change IRQ
>>>  	 * - bus error IRQ and bus error reporting is activated
>>>  	 */
>>> -	if ((reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_AVAILABLE) ||
>>> +	if ((reg_iflag1 & ~(1 << FLEXCAN_TX_BUF_ID)) || reg_iflag2 ||
>>>  	    (reg_esr & FLEXCAN_ESR_ERR_STATE) ||
>>>  	    flexcan_has_and_handle_berr(priv, reg_esr)) {
>>>  		/*
>>> @@ -805,20 +947,10 @@ static irqreturn_t flexcan_irq(int irq, void *d=
ev_id)
>>>  		 * save them for later use.
>>>  		 */
>>>  		priv->reg_esr =3D reg_esr & FLEXCAN_ESR_ERR_BUS;
>>> -		flexcan_write(FLEXCAN_IFLAG_DEFAULT &
>>> -			~FLEXCAN_IFLAG_RX_FIFO_AVAILABLE, &regs->imask1);
>>
>> You have to disable all RX irqs here.
>=20
> Why? The handler is not re-entrant, and I am going to clear all MB's in=
 the
> handler anyway.
>=20
>>> -		flexcan_write(priv->reg_ctrl_default &
>>> ~FLEXCAN_CTRL_ERR_ALL,
>>> -		       &regs->ctrl);
>>> +		flexcan_copy_rxmbs(priv, reg_iflag1, reg_iflag2);
>>>  		napi_schedule(&priv->napi);
>>>  	}
>>> =20
>>> -	/* FIFO overflow */
>>> -	if (reg_iflag1 & FLEXCAN_IFLAG_RX_FIFO_OVERFLOW) {
>>> -		flexcan_write(FLEXCAN_IFLAG_RX_FIFO_OVERFLOW,
>>> &regs->iflag1);
>>> -		dev->stats.rx_over_errors++;
>>> -		dev->stats.rx_errors++;
>>> -	}
>>> -
>>>  	/* transmission complete interrupt */
>>>  	if (reg_iflag1 & (1 << FLEXCAN_TX_BUF_ID)) {
>>>  		stats->tx_bytes +=3D can_get_echo_skb(dev, 0);
>>> @@ -911,11 +1043,11 @@ static int flexcan_chip_start(struct net_devic=
e
>>> *dev) *
>>>  	 */
>>>  	reg_mcr =3D flexcan_read(&regs->mcr);
>>> -	reg_mcr &=3D ~FLEXCAN_MCR_MAXMB(0xff);
>>> -	reg_mcr |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_FEN | FLEXCAN_MCR_HALT |=

>>> +	reg_mcr &=3D ~(FLEXCAN_MCR_MAXMB(0xff) | FLEXCAN_MCR_FEN);
>>> +	reg_mcr |=3D FLEXCAN_MCR_FRZ | FLEXCAN_MCR_HALT |
>>>  		FLEXCAN_MCR_SUPV | FLEXCAN_MCR_WRN_EN |
>>>  		FLEXCAN_MCR_IDAM_C | FLEXCAN_MCR_SRX_DIS |
>>> -		FLEXCAN_MCR_MAXMB(FLEXCAN_TX_BUF_ID);
>>> +		FLEXCAN_MCR_BCC | FLEXCAN_MCR_MAXMB(0x3f);
>>
>> Please create a define for this.
>=20
> Ok, but I would have some explaining to do probably... since 0x40 shoul=
d be
> the correct value, but due to the documentation of older IP versions, t=
his
> cannot be more than 0x3f. I will try to make this clear in the next ver=
sion...
>=20
>>
>>>  	netdev_dbg(dev, "%s: writing mcr=3D0x%08x", __func__, reg_mcr);
>>>  	flexcan_write(reg_mcr, &regs->mcr);
>>> =20
>>> @@ -951,28 +1083,36 @@ static int flexcan_chip_start(struct net_devic=
e
>>> *dev) netdev_dbg(dev, "%s: writing ctrl=3D0x%08x", __func__, reg_ctrl=
);
>>>  	flexcan_write(reg_ctrl, &regs->ctrl);
>>> =20
>>> -	/* clear and invalidate all mailboxes first */
>>> -	for (i =3D FLEXCAN_TX_BUF_ID; i < ARRAY_SIZE(regs->cantxfg); i++) {=

>>> -		flexcan_write(FLEXCAN_MB_CODE_RX_INACTIVE,
>>> +	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES) {
>>> +		/* CTRL2: Enable EACEN */
>>> +		reg_crl2 =3D flexcan_read(&regs->crl2);
>>> +		reg_crl2 |=3D FLEXCAN_CTRL2_EACEN;
>>> +		flexcan_write(reg_crl2, &regs->crl2);
>>> +	}
>>> +
>>> +	/* Prepare mailboxes. Skip the first, use one for TX the rest for
>>> RX */
>>> +	for (i =3D 1; i < ARRAY_SIZE(regs->cantxfg); i++) {
>>> +		if (i =3D=3D FLEXCAN_TX_BUF_ID)
>>> +			flexcan_write(FLEXCAN_MB_CNT_CODE(0x8),
>>> +				&regs->cantxfg[i].can_ctrl);
>> Please use sensible values for the array to start, move the TX mailbox=

>> initialization out of this loop.
>=20
> Ok, but see my caveat above.... what to do?
>=20
>>> +		else
>>> +			flexcan_write(FLEXCAN_MB_CNT_CODE(0x4),
>>>  			      &regs->cantxfg[i].can_ctrl);
>>> +		flexcan_write(0, &regs->rximr[i]); /* Clear filter */
>>>  	}
>>> =20
>>>  	/* Errata ERR005829: mark first TX mailbox as INACTIVE */
>>>  	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
>>>  		      &regs->cantxfg[FLEXCAN_TX_BUF_RESERVED].can_ctrl);
>>> =20
>>> -	/* mark TX mailbox as INACTIVE */
>>> -	flexcan_write(FLEXCAN_MB_CODE_TX_INACTIVE,
>>> -		      &regs->cantxfg[FLEXCAN_TX_BUF_ID].can_ctrl);
>>> +	priv->second_first =3D 0;
>>> +	priv->rx_idx =3D 0;
>>> =20
>>>  	/* acceptance mask/acceptance code (accept everything) */
>>>  	flexcan_write(0x0, &regs->rxgmask);
>>>  	flexcan_write(0x0, &regs->rx14mask);
>>>  	flexcan_write(0x0, &regs->rx15mask);
>>> =20
>>> -	if (priv->devtype_data->features & FLEXCAN_HAS_V10_FEATURES)
>>> -		flexcan_write(0x0, &regs->rxfgmask);
>>> -
>>
>> This is only fifo related, right?
>=20
> From the RM:
>  "26.7.16 Rx FIFO Global Mask Register (FLEXCANx_RXFGMASK)"
>=20
> Guess it does nothing if the FIFO is unused....
>=20
>>
>>>  	/*
>>>  	 * On Vybrid, disable memory error detection interrupts
>>>  	 * and freeze mode.
>>> @@ -1009,8 +1149,9 @@ static int flexcan_chip_start(struct net_device=
 *dev)
>>> =20
>>>  	priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
>>> =20
>>> -	/* enable FIFO interrupts */
>>> -	flexcan_write(FLEXCAN_IFLAG_DEFAULT, &regs->imask1);
>>> +	/* enable all MB interrupts */
>>> +	flexcan_write(FLEXCAN_IFLAG1_DEFAULT, &regs->imask1);
>>> +	flexcan_write(FLEXCAN_IFLAG2_DEFAULT, &regs->imask2);
>>> =20
>>>  	/* print chip status */
>>>  	netdev_dbg(dev, "%s: reading mcr=3D0x%08x ctrl=3D0x%08x\n", __func_=
_,
>>>
>>
>> Marc
>=20
> Thanks for the comments...
>=20
> Best regards,
>=20

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



--F763gaBgNXD2MDRVMiKwc1caCp75N91ef
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlQlM3MACgkQjTAFq1RaXHOrNgCfW7HYF+xbI37DLCIitiGu/SqX
+MEAniVC1za/15S/NFgbaMv4Sp5J0ZZm
=5+J+
-----END PGP SIGNATURE-----

--F763gaBgNXD2MDRVMiKwc1caCp75N91ef--
