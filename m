From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 2/2] Allwinner SoC CAN controller Support
Date: Thu, 10 Sep 2015 10:17:59 +0200
Message-ID: <55F13CB7.6050603@pengutronix.de>
References: <1441274970-5632-1-git-send-email-info@gerhard-bertelsmann.de>
 <1441274970-5632-3-git-send-email-info@gerhard-bertelsmann.de>
 <55EEBDC4.8050800@pengutronix.de>
 <19003c5e5894dc0d656490cd17be1bcb@mail.rdts.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="2jbUwMG8347h4AjisxHlML5VtidFXiwhP"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58737 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753132AbbIJISJ (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 10 Sep 2015 04:18:09 -0400
In-Reply-To: <19003c5e5894dc0d656490cd17be1bcb@mail.rdts.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Gerhard Bertelsmann <info@gerhard-bertelsmann.de>
Cc: linux-can@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2jbUwMG8347h4AjisxHlML5VtidFXiwhP
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/10/2015 08:29 AM, Gerhard Bertelsmann wrote:

>>> +
>>> +/* Registers address */
>>
>> Please prefix _all_ your defines with a common prefix, e.g. SUNXI_
>>
>>> +#define CAN_BASE0		0x01C2BC00
>>
>> Please remove that define, the base address comes from the DT now.
>=20
> fixed - in next version, but I personally like to see which IO address
> is the code talking about. If you aren't aware of the address, you have=

> need some time to find it in the docs.

This might make sense now, where there only a single instance of this
core on 2 SoC. But in general it's of no use, as the base address comes
from the DT, have a look at the flexcan core, it's supported on more
then 5 SoCs, with more than one cores on some SoCs. This define is not
used it's redundant information just look at the DT, that's where the
base address comes from.

[...]

>>> +static void sunxi_can_write_cmdreg(struct sunxican_priv *priv, u8=20
>>> val)
>>> +{
>>> +	unsigned long flags;
>>> +
>>> +	 /* The command register needs some locking and time to settle
>>> +	  * the write_reg() operation - especially on SMP systems.
>>> +	  */
>>
>> Is this needed with your SJA1000 alike IP core?
>=20
> IMHO the Allwinner CAN IP isn't a real SJA1000. It's like a SJA1000 -
> not more. The extra reading doesn't hurt IMHO ...

just performance - keep it just to be on the save side.

[...]

>>> +{
>>> +	struct sunxican_priv *priv =3D netdev_priv(dev);
>>> +	u8 status =3D readl(priv->base + CAN_MSEL_ADDR);
>>> +	int i;
>>> +
>>> +	for (i =3D 0; i < 100; i++) {
>>> +		/* check reset bit */
>>> +		if ((status & RESET_MODE) =3D=3D 0) {
>>> +			priv->can.state =3D CAN_STATE_ERROR_ACTIVE;
>>> +			/* enable interrupts */
>>> +			if (priv->can.ctrlmode & CAN_CTRLMODE_BERR_REPORTING) {
>>> +				writel(0xFFFF, priv->base + CAN_INTEN_ADDR);
>>> +			} else {
>>> +				writel(0xFFFF & ~BERR_IRQ_EN,
>>> +				       priv->base + CAN_INTEN_ADDR);
>>> +			}
>>> +
>>> +			if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
>>> +				/* Put device into loopback mode */
>>
>> That's not loopback mode according to socketcan, that's
>> CAN_CTRLMODE_PRESUME_ACK.
>=20
> isn't CAN_CTRLMODE_LOOPBACK loopback mode ? May I can't see the obvious=
=20
> here ...

No - look at the datsheet - and the original sja1000 driver

CAN_CTRLMODE_LOOPBACK is command register bit 4
And it means you receive the frame (via the transceiver) you are just
sending.

CAN_CTRLMODE_PRESUME_ACK means the frame is send successfully, even if
there is no other CAN station on the bus. The other station is supposed
to send an ACK to signal correct reception, if there is no ACK the frame
is repeated. According to the datasheet that is what mode selection
register bit 2 does.

>>> +				writel(readl(priv->base + CAN_MSEL_ADDR) |
>>> +				       LOOPBACK_MODE,
>>> +				       priv->base + CAN_MSEL_ADDR);
>>> +			} else if
>>> +				(priv->can.ctrlmode & CAN_CTRLMODE_LISTENONLY) {
>>> +				/* Put device into listen-only mode */
>>> +				writel(readl(priv->base + CAN_MSEL_ADDR) |
>>> +				       LISTEN_ONLY_MODE,
>>> +				       priv->base + CAN_MSEL_ADDR);
>>> +			}
>>> +			return;
>>> +		}
>>> +		/* set chip to normal mode */
>>> +		writel(readl(priv->base + CAN_MSEL_ADDR) & (~RESET_MODE),
>>> +		       priv->base + CAN_MSEL_ADDR);
>>> +		status =3D readl(priv->base + CAN_MSEL_ADDR);
>>> +	}

[...]

>>> +/* transmit a CAN message
>>> + * message layout in the sk_buff should be like this:
>>> + * xx xx xx xx         ff         ll 00 11 22 33 44 55 66 77
>>> + * [ can_id ] [flags] [len] [can data (up to 8 bytes]
>>> + */
>>> +static int sunxican_start_xmit(struct sk_buff *skb, struct net_devic=
e=20
>>> *dev)
>>> +{
>>> +	struct sunxican_priv *priv =3D netdev_priv(dev);
>>> +	struct can_frame *cf =3D (struct can_frame *)skb->data;
>>> +	u8 dlc;
>>> +	canid_t id;
>>> +	u32 temp =3D 0;
>>> +	int i;
>>> +
>>> +	/* wait buffer ready */
>>> +	while (!(readl(priv->base + CAN_STA_ADDR) & TBUF_RDY))
>>> +		usleep_range(10, 100);
>>
>> Can you explain why you need this sleep here?
>=20
> IMHO its needed. How could you guarantee that the previous transmit is =

> finished
> otherwise ?

Nope - this driver already implements proper flow control.... see below:

>>> +
>>> +	if (can_dropped_invalid_skb(dev, skb))
>>> +		return NETDEV_TX_OK;
>>> +
>>> +	netif_stop_queue(dev);

The core has just one transmit buffer. Right?
So when sending a CAN frame the send queue from the networking stack
into the driver is stopped. In the interrupt handler, when a TX-complete
interrupt occurs the queue is started again.

For testing purposes you can add the following:

	if (!(readl(priv->base + CAN_STA_ADDR) & TBUF_RDY))
		printf("%s: xmit while buffer not ready\n", __func__);

>>> +
>>> +	dlc =3D cf->can_dlc;
>>> +	id =3D cf->can_id;
>>> +
>>> +	temp =3D ((id >> 30) << 6) | dlc;
>>
>> Please don't reply on the fact that the upper two bits of id match the=

>> upper two bits for temp. Please use an explizid conversion via:
>> 	if (id & ..)
>> 		temp |=3D BIT_FOO;
>=20
> fixed - in next version
>=20
>>
>>> +	writel(temp, priv->base + CAN_BUF0_ADDR);
>>> +	if (id & CAN_EFF_FLAG) {
>>> +		/* extended frame */
>>> +		writel((id >> 21) & 0xFF, priv->base + CAN_BUF1_ADDR);
>>> +		writel((id >> 13) & 0xFF, priv->base + CAN_BUF2_ADDR);
>>> +		writel((id >> 5)  & 0xFF, priv->base + CAN_BUF3_ADDR);
>>> +		writel((id & 0x1F) << 3,  priv->base + CAN_BUF4_ADDR);
>>
>> Can you make it always first shift then mask or the other way round.=20
>> see
>> the original sja1000 xmit() functio, that look pretty neat.
>=20
> fixed - in next version. I like shifting first and mask afterwards.
> In fact, it's using less soucre code chars ;-)

Do as you like, but make it the same for all assignments :) Or better
copy the code from the original sja1000 driver.

>=20
>>
>>> +
>>> +		for (i =3D 0; i < dlc; i++) {
>>> +			writel(cf->data[i],
>>> +			       priv->base + (CAN_BUF5_ADDR + i * 4));
>>> +		}
>>> +	} else {
>>> +		/* standard frame */
>>> +		writel((id >> 3) & 0xFF, priv->base + CAN_BUF1_ADDR);
>>> +		writel((id & 0x7) << 5, priv->base + CAN_BUF2_ADDR);
>>> +
>>> +		for (i =3D 0; i < dlc; i++)
>>> +			writel(cf->data[i], priv->base + CAN_BUF3_ADDR + i * 4);
>>> +	}
>>> +	can_put_echo_skb(skb, dev, 0);
>>
>> Do you have support for one_shot or loopback mode here, too. Like the
>> sja1000?
>=20
> Hmm - will have a look at this ...

See discussion about loopback above (and the original sja100 driver).

[...]

>>> +	if (request_irq
>>> +	    (dev->irq, sunxi_can_interrupt, IRQF_TRIGGER_NONE, dev->name,
>>                                             ^^^^^^^^^^^^^^^^^
>> Please make it a IRQF_SHARED.
>>
>>
>>> +	     (void *)dev)) {
>>              ^^^^^^^^
>> cast not needed
>=20
> fixed - in next version. BTW: the sja1000 in linux-next has also this=20
> cast.

But we want to do better, don't we. (send patches if you like.)

>>> +	clk =3D clk_get(&pdev->dev, "apb1_can");
>>> +	if (IS_ERR(clk)) {
>>> +		dev_err(&pdev->dev, "no clock defined\n");
>>> +		err =3D -ENODEV;
>>> +		goto exit;
>>> +	}
>>> +	/* turn on clocking for CAN peripheral block */
>>> +	err =3D clk_prepare_enable(clk);
>>
>> Please move the clock handling into the open() function. Or better=20
>> think
>> about implementing runtimepm.
>=20
> Why ? It feels like the right place. The CAN core clock starts when the=
=20
> module is
> loaded.

Naively thinking yes, but why turn on the clocks when you load the
module? Just increases power consumption but serves no purpose. So move
prepare_enable and disable_unprepare into open/close. We have to take
care about get_berrcounter, though.

>>> +static SIMPLE_DEV_PM_OPS(sunxi_can_pm_ops, sunxi_can_suspend,=20
>>> sunxi_can_resume);

BTW: have you tested suspend and resume?

>>> +
>>> +static struct platform_driver sunxi_can_driver =3D {
>>> +	.driver =3D {
>>> +		   .name =3D DRV_NAME,
>>
>> Please remove the .name.
>=20
> Without it, the kernel oops

Doh! But there was one assignment here, that was not needed...I'll try
to remember which one it was.

>>
>>> +		   .owner =3D THIS_MODULE,

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--2jbUwMG8347h4AjisxHlML5VtidFXiwhP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJV8Ty3AAoJEP5prqPJtc/HybcH/02WPlGTOQ8VePAmRYMxF3CG
CSc4vhP2658kGIv+AKdliOlYetuVDsJd1c8UdcyNKPWBp+AxO5agkQAAOT5q9lsb
FkzYqxFMJaWlg+3vq6DJqbA7KHlK35nHD3LFq0VfuAxq4zgAogPWTHNKOCiRGhyL
ybNZhjamHA/lRWLVpf9jqVAypjmqOqWJroJ1qhphwrmsGQs3kJC233jzUh9Nw5rk
lr8QVdHP5N+XM2fFn+eTKOVygaUnFyXTU9rG0UqqaGynzdWAiw9dJw59uxNXjv+Q
UkB/8rSrsDyFdBB/FO0K+VG76E5IS1HIH2frmo2N2zTKJR7nDHcGRXPDJ8Wc0uA=
=lT6p
-----END PGP SIGNATURE-----

--2jbUwMG8347h4AjisxHlML5VtidFXiwhP--
