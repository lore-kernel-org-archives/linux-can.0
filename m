From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH v2 1/1] can: m_can: add Bosch M_CAN controller support
Date: Mon, 07 Jul 2014 12:24:03 +0200
Message-ID: <53BA7543.70901@pengutronix.de>
References: <1404474812-16855-1-git-send-email-b29396@freescale.com> <53B69C55.8010901@pengutronix.de> <20140707071040.GA18505@shlinux1.ap.freescale.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="FLhrcCIj8iOmfuPrh1R3eSFP4TSV7BSBf"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43369 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913AbaGGKYP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 7 Jul 2014 06:24:15 -0400
In-Reply-To: <20140707071040.GA18505@shlinux1.ap.freescale.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Dong Aisheng <b29396@freescale.com>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--FLhrcCIj8iOmfuPrh1R3eSFP4TSV7BSBf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 07/07/2014 09:10 AM, Dong Aisheng wrote:
> On Fri, Jul 04, 2014 at 02:21:41PM +0200, Marc Kleine-Budde wrote:
>> On 07/04/2014 01:53 PM, Dong Aisheng wrote:
>>> The patch adds the basic CAN TX/RX function support for Bosch M_CAN c=
ontroller.
>>> For TX, only one dedicated tx buffer is used for sending data.
>>> For RX, RXFIFO 0 is used for receiving data to avoid overflow.
>>> Rx FIFO 1 and Rx Buffers are not used currently, as well as Tx Event =
FIFO.
>>>
>>> Due to the message ram can be shared by multi m_can instances
>>> and the fifo element is configurable which is SoC dependant,
>>> the design is to parse the message ram related configuration data fro=
m device
>>> tree rather than hardcode define it in driver which can make the mess=
age
>>> ram sharing fully transparent to M_CAN controller driver,
>>> then we can gain better driver maintainability and future features up=
grade.
>>>
>>> M_CAN also supports CANFD protocol features like data payload up to 6=
4 bytes
>>> and bitrate switch at runtime, however, this patch still does not add=
 the
>>> support for these features.
>>>
>>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>>
>> Looks quite god, comments inline.
>> Marc
>>> ---
>>> Changes since v1:
>>> Addressed all comments from Mark Rutland, Hartkopp and Marc Kleine-Bu=
dde
>>> - merge three patches into one
>>> - create directory drivers/net/can/m_can
>>> - improve binding doc
>>> - make sure using valid pointer before netif_receive_skb(skb)
>>> - remove debug info a bit
>>> - let the stats are updated even if alloc_can_err_skb() fails
>>> - other small fixes
>>>
>>> Test result:
>>> Passed over night can-utils/canfdtest stress test on iMX6SX SDB board=
=2E
>>>
>>> ---
>>>  .../devicetree/bindings/net/can/m_can.txt          |   65 ++
>>
>> Please put the DT binding doc into a separate patch.
>>
>=20
> Okay
>=20
>>>  drivers/net/can/Kconfig                            |    2 +
>>>  drivers/net/can/Makefile                           |    1 +
>>>  drivers/net/can/m_can/Kconfig                      |    4 +
>>>  drivers/net/can/m_can/Makefile                     |    7 +
>>>  drivers/net/can/m_can/m_can.c                      | 1136 ++++++++++=
++++++++++
>>>  6 files changed, 1215 insertions(+), 0 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/net/can/m_can.t=
xt
>>>  create mode 100644 drivers/net/can/m_can/Kconfig
>>>  create mode 100644 drivers/net/can/m_can/Makefile
>>>  create mode 100644 drivers/net/can/m_can/m_can.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Do=
cumentation/devicetree/bindings/net/can/m_can.txt
>>> new file mode 100644
>>> index 0000000..3422790
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/can/m_can.txt
>>> @@ -0,0 +1,65 @@
>>> +Bosch MCAN controller Device Tree Bindings
>>> +-------------------------------------------------
>>> +
>>> +Required properties:
>>> +- compatible		: Should be "bosch,m_can" for M_CAN controllers
>>> +- reg			: physical base address and size of the M_CAN
>>> +			  registers map and Message RAM
>>> +- reg-names		: Should be "m_can" and "message_ram"
>>> +- interrupts		: Should be the interrupt number of M_CAN interrupt
>>> +			  line 0 and line 1, could be same if sharing
>>> +			  the same interrupt.
>>> +- interrupt-names	: Should contain "int0" and "int1"
>>
>> You make only use of one interupt in the driver.
>>
>=20
> Yes, that's the purpose.
> In driver, we will route all interrupts to INT0.
> So not need parse INT1 currently.
> However, we still define two interrupts in device tree binding
> according to hw capability.
> It could be helpful if anyone want to implement features like
> separate different type of interrupts to different interrupt line
> in the future.

Okay, do I understand you correctly, it is possible to configure each
interrupt source which interrupt shall be triggered?

>>> +- clocks		: Clocks used by controller, should be host clock
>>> +			  and CAN clock.
>>> +- clock-names		: Should contain "hclk" and "cclk"
>>> +- pinctrl-<n>		: Pinctrl states as described in bindings/pinctrl/pin=
ctrl-bindings.txt
>>> +- pinctrl-names		: Names corresponding to the numbered pinctrl state=
s
>>
>> is pinctrl really required?

> AFAIK yes.
> Is there an exception?

The driver does not enforce pinctrl, but you will probably have non
functional CAN, then :). So leave it as required.

[...]

>>> +static void m_can_read_fifo(const struct net_device *dev, struct can=
_frame *cf,
>>> +				u32 rxfs)
>>> +{
>>> +	struct m_can_priv *priv =3D netdev_priv(dev);
>>> +	u32 flags, fgi;
>>> +	void __iomem *fifo_addr;
>>> +
>>> +	fgi =3D (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
>>
>> Just for curiosity, what do the fgi bits tell us?

> It is FIFO Get index.
> See the following spec definition:
> Bit 21:16 F0PI[5:0]: Rx FIFO 0 Put Index
> Rx FIFO 0 write index pointer, range 0 to 63.
> Bit 13:8 F0GI[5:0]: Rx FIFO 0 Get Index
> Rx FIFO 0 read index pointer, range 0 to 63.
>=20
> It tells us the current element index to be read in the FIFO.
>=20
> When reading from an Rx FIFO, Rx FIFO Get Index RXFnS.FnGI * FIFO Eleme=
nt
> Size has to be added to the corresponding Rx FIFO start address RXFnC.F=
nSA.

Thanks for the explanation.

>>> +	fifo_addr =3D priv->mram_base + priv->rxf0_off + fgi * RXF0_ELEMENT=
_SIZE;
>>> +	flags =3D readl(fifo_addr);
>>
>> What about a function introducing a function?
>> static inline u32 m_can_fifo_read(const struct m_can_priv *priv priv,
>> u32 fgi, unsgined int offset)

> If do that, this function mostly does the same thing as m_can_read_fifo=

> (we also need pass the cf to it to handle can frame),
> i'm not sure what obvious benefit we can get.
> Maybe we could re-range function later when adding FIFO 1 & CANFD Frame=

> support, then we know clear about what we need to do.

I was just thinking about somethink like this:

static inline u32 m_can_fifo_read(const struct m_can_priv *priv priv,
                                  u32 fgi, unsgined int offset)
{
	return m_can_read(priv, priv->mram_base + priv->rxf0_off +
                          fgi * RXF0_ELEMENT_SIZE + offset)
}

Regarding the mram and the offsets:

> 	fifo_addr =3D priv->mram_base + priv->rxf0_off + fgi * RXF0_ELEMENT_SI=
ZE;
> 	fifo_addr =3D priv->mram_base + priv->mram_off + priv->txb_off;

Why is rxf0_off used without the mram_off and txb_off with the mram_off?
Can you please test your driver with a mram offset !=3D in your DT.

If I understand the code in m_can_of_parse_mram() correctly the
individual *_off are already offsets to the *mram_base, so mram_off
should not be used within the driver. I even think mram_off should be
removed from the priv. Do the *_off and *_elems fit into a u8 or u16? If
so it makes sense to convert the priv accordingly.

What about putting the offset and the number of elements into a struct
and make use an array for rxf{0,1}?

>>> +static struct net_device *alloc_m_can_dev(void)
>>> +{
>>> +	struct net_device *dev;
>>> +	struct m_can_priv *priv;
>>> +
>>> +	dev =3D alloc_candev(sizeof(struct m_can_priv), 1);
>>> +	if (!dev)
>>> +		return NULL;
>>> +
>>> +	priv =3D netdev_priv(dev);
>>> +	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
>>> +
>>> +	priv->dev =3D dev;
>>> +	priv->can.bittiming_const =3D &m_can_bittiming_const;
>>> +	priv->can.do_set_mode =3D m_can_set_mode;
>>> +	priv->can.do_get_berr_counter =3D m_can_get_berr_counter;
>>> +	priv->can.ctrlmode_supported =3D CAN_CTRLMODE_LOOPBACK |
>>> +					CAN_CTRLMODE_LISTENONLY |
>>> +					CAN_CTRLMODE_BERR_REPORTING;
>>
>> Please take care of CAN_CTRLMODE_BERR_REPORTING, i.e. only enable bus
>> the bus error interrupt if this bit is set.
>>
>=20
> Okay, BTW, does BERR_REPROTING includes lost message error?

The lost message interrupt should always be enabled and reported via a
CAN error message.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--FLhrcCIj8iOmfuPrh1R3eSFP4TSV7BSBf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlO6dUMACgkQjTAFq1RaXHOvnQCgleXGud3KRsMrL7DdYWGH9bqO
TM4An0w9XwKOMnqdAwDIq8FfEsKzRnue
=rNcK
-----END PGP SIGNATURE-----

--FLhrcCIj8iOmfuPrh1R3eSFP4TSV7BSBf--
