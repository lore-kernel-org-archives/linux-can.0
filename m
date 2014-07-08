From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v2 1/1] can: m_can: add Bosch M_CAN controller support
Date: Tue, 8 Jul 2014 18:30:11 +0800
Message-ID: <20140708103009.GA21754@shlinux1.ap.freescale.net>
References: <1404474812-16855-1-git-send-email-b29396@freescale.com>
 <53B69C55.8010901@pengutronix.de>
 <20140707071040.GA18505@shlinux1.ap.freescale.net>
 <53BA7543.70901@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from dns-bn1lp0143.outbound.protection.outlook.com ([207.46.163.143]:22761
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753141AbaGHKc5 (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Tue, 8 Jul 2014 06:32:57 -0400
Content-Disposition: inline
In-Reply-To: <53BA7543.70901@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

On Mon, Jul 07, 2014 at 12:24:03PM +0200, Marc Kleine-Budde wrote:
> On 07/07/2014 09:10 AM, Dong Aisheng wrote:
> > On Fri, Jul 04, 2014 at 02:21:41PM +0200, Marc Kleine-Budde wrote:
> >> On 07/04/2014 01:53 PM, Dong Aisheng wrote:
> >>> The patch adds the basic CAN TX/RX function support for Bosch M_CAN controller.
> >>> For TX, only one dedicated tx buffer is used for sending data.
> >>> For RX, RXFIFO 0 is used for receiving data to avoid overflow.
> >>> Rx FIFO 1 and Rx Buffers are not used currently, as well as Tx Event FIFO.
> >>>
> >>> Due to the message ram can be shared by multi m_can instances
> >>> and the fifo element is configurable which is SoC dependant,
> >>> the design is to parse the message ram related configuration data from device
> >>> tree rather than hardcode define it in driver which can make the message
> >>> ram sharing fully transparent to M_CAN controller driver,
> >>> then we can gain better driver maintainability and future features upgrade.
> >>>
> >>> M_CAN also supports CANFD protocol features like data payload up to 64 bytes
> >>> and bitrate switch at runtime, however, this patch still does not add the
> >>> support for these features.
> >>>
> >>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> >>
> >> Looks quite god, comments inline.
> >> Marc
> >>> ---
> >>> Changes since v1:
> >>> Addressed all comments from Mark Rutland, Hartkopp and Marc Kleine-Budde
> >>> - merge three patches into one
> >>> - create directory drivers/net/can/m_can
> >>> - improve binding doc
> >>> - make sure using valid pointer before netif_receive_skb(skb)
> >>> - remove debug info a bit
> >>> - let the stats are updated even if alloc_can_err_skb() fails
> >>> - other small fixes
> >>>
> >>> Test result:
> >>> Passed over night can-utils/canfdtest stress test on iMX6SX SDB board.
> >>>
> >>> ---
> >>>  .../devicetree/bindings/net/can/m_can.txt          |   65 ++
> >>
> >> Please put the DT binding doc into a separate patch.
> >>
> > 
> > Okay
> > 
> >>>  drivers/net/can/Kconfig                            |    2 +
> >>>  drivers/net/can/Makefile                           |    1 +
> >>>  drivers/net/can/m_can/Kconfig                      |    4 +
> >>>  drivers/net/can/m_can/Makefile                     |    7 +
> >>>  drivers/net/can/m_can/m_can.c                      | 1136 ++++++++++++++++++++
> >>>  6 files changed, 1215 insertions(+), 0 deletions(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt
> >>>  create mode 100644 drivers/net/can/m_can/Kconfig
> >>>  create mode 100644 drivers/net/can/m_can/Makefile
> >>>  create mode 100644 drivers/net/can/m_can/m_can.c
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
> >>> new file mode 100644
> >>> index 0000000..3422790
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/net/can/m_can.txt
> >>> @@ -0,0 +1,65 @@
> >>> +Bosch MCAN controller Device Tree Bindings
> >>> +-------------------------------------------------
> >>> +
> >>> +Required properties:
> >>> +- compatible		: Should be "bosch,m_can" for M_CAN controllers
> >>> +- reg			: physical base address and size of the M_CAN
> >>> +			  registers map and Message RAM
> >>> +- reg-names		: Should be "m_can" and "message_ram"
> >>> +- interrupts		: Should be the interrupt number of M_CAN interrupt
> >>> +			  line 0 and line 1, could be same if sharing
> >>> +			  the same interrupt.
> >>> +- interrupt-names	: Should contain "int0" and "int1"
> >>
> >> You make only use of one interupt in the driver.
> >>
> > 
> > Yes, that's the purpose.
> > In driver, we will route all interrupts to INT0.
> > So not need parse INT1 currently.
> > However, we still define two interrupts in device tree binding
> > according to hw capability.
> > It could be helpful if anyone want to implement features like
> > separate different type of interrupts to different interrupt line
> > in the future.
> 
> Okay, do I understand you correctly, it is possible to configure each
> interrupt source which interrupt shall be triggered?
> 

Yes, we configure them in Interrupt Enable (IE) register, each bit represents
one interrupt source.
Besides IE register, there's Interrupt Line Select (ILS) register which
controls each interrupt source is routed to which interrupt line (int0 or int1).
Be default, we route all interrupts source to int0.

> >>> +- clocks		: Clocks used by controller, should be host clock
> >>> +			  and CAN clock.
> >>> +- clock-names		: Should contain "hclk" and "cclk"
> >>> +- pinctrl-<n>		: Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
> >>> +- pinctrl-names		: Names corresponding to the numbered pinctrl states
> >>
> >> is pinctrl really required?
> 
> > AFAIK yes.
> > Is there an exception?
> 
> The driver does not enforce pinctrl, but you will probably have non
> functional CAN, then :). So leave it as required.
> 
> [...]
> 
> >>> +static void m_can_read_fifo(const struct net_device *dev, struct can_frame *cf,
> >>> +				u32 rxfs)
> >>> +{
> >>> +	struct m_can_priv *priv = netdev_priv(dev);
> >>> +	u32 flags, fgi;
> >>> +	void __iomem *fifo_addr;
> >>> +
> >>> +	fgi = (rxfs & RXFS_FGI_MASK) >> RXFS_FGI_OFF;
> >>
> >> Just for curiosity, what do the fgi bits tell us?
> 
> > It is FIFO Get index.
> > See the following spec definition:
> > Bit 21:16 F0PI[5:0]: Rx FIFO 0 Put Index
> > Rx FIFO 0 write index pointer, range 0 to 63.
> > Bit 13:8 F0GI[5:0]: Rx FIFO 0 Get Index
> > Rx FIFO 0 read index pointer, range 0 to 63.
> > 
> > It tells us the current element index to be read in the FIFO.
> > 
> > When reading from an Rx FIFO, Rx FIFO Get Index RXFnS.FnGI * FIFO Element
> > Size has to be added to the corresponding Rx FIFO start address RXFnC.FnSA.
> 
> Thanks for the explanation.
> 
> >>> +	fifo_addr = priv->mram_base + priv->rxf0_off + fgi * RXF0_ELEMENT_SIZE;
> >>> +	flags = readl(fifo_addr);
> >>
> >> What about a function introducing a function?
> >> static inline u32 m_can_fifo_read(const struct m_can_priv *priv priv,
> >> u32 fgi, unsgined int offset)
> 
> > If do that, this function mostly does the same thing as m_can_read_fifo
> > (we also need pass the cf to it to handle can frame),
> > i'm not sure what obvious benefit we can get.
> > Maybe we could re-range function later when adding FIFO 1 & CANFD Frame
> > support, then we know clear about what we need to do.
> 
> I was just thinking about somethink like this:
> 
> static inline u32 m_can_fifo_read(const struct m_can_priv *priv priv,
>                                   u32 fgi, unsgined int offset)
> {
> 	return m_can_read(priv, priv->mram_base + priv->rxf0_off +
>                           fgi * RXF0_ELEMENT_SIZE + offset)
> }
> 

Understand, i'm fine with this way.

> Regarding the mram and the offsets:
> 
> > 	fifo_addr = priv->mram_base + priv->rxf0_off + fgi * RXF0_ELEMENT_SIZE;
> > 	fifo_addr = priv->mram_base + priv->mram_off + priv->txb_off;
> 
> Why is rxf0_off used without the mram_off and txb_off with the mram_off?
> Can you please test your driver with a mram offset != in your DT.
> 
> If I understand the code in m_can_of_parse_mram() correctly the
> individual *_off are already offsets to the *mram_base, so mram_off
> should not be used within the driver.

Good catch!
You're right! I aslo found this recently!
txb_off already includes the mram_off so should not plus mram_off again.
The former test did not find it because it's still not exceed the 16K ram
size for m_can0. But m_can1 has such issue.

> I even think mram_off should be removed from the priv.

Right, i also think so.

It is used for debug information formerly that we need mram_off
to calculate each element address in the fifo.

By removing mram_off, i'm going to change the debug information to:
dev_dbg(&pdev->dev, "mram_base %p sidf 0x%x %d xidf 0x%x %d rxf0 %x %d rxf1 %x %d rxb %x %d txe %x %d txb %x %d\n",
	priv->mram_base, priv->sidf_off, priv->sidf_elems,
	priv->xidf_off, priv->xidf_elems, priv->rxf0_off,
	priv->rxf0_elems, priv->rxf1_off, priv->rxf1_elems,
	priv->rxb_off, priv->rxb_elems, priv->txe_off,
	priv->txe_elems, priv->txb_off, priv->txb_elems);

The annoying thing is the line has to be a much bigger one to avoid
checkpatch warning of "WARNING: quoted string split across lines".

What's your suggestion for such issue?
Keeping the big line or split into two lines and leave checkpatch warning there?

> Do the *_off and *_elems fit into a u8 or u16? If
> so it makes sense to convert the priv accordingly.
> 

Yes, *_off fit into u16 since MRAM has a maximum of 4352 words(17K).
And *_elems fit into u8 since the max number is 128.
I will change them accordingly.

> What about putting the offset and the number of elements into a struct
> and make use an array for rxf{0,1}?
> 

You mean something like below?
struct mram_cfg {
	u16 off;
	u8  elements;
};

struct m_can_priv {
	........

        struct mram_cfg sidf;
        struct mram_cfg xidf;
        struct mram_cfg rxf0;
        struct mram_cfg rxf1;
	......
        struct mram_cfg txb;
};

Regards
Dong Aisheng

> >>> +static struct net_device *alloc_m_can_dev(void)
> >>> +{
> >>> +	struct net_device *dev;
> >>> +	struct m_can_priv *priv;
> >>> +
> >>> +	dev = alloc_candev(sizeof(struct m_can_priv), 1);
> >>> +	if (!dev)
> >>> +		return NULL;
> >>> +
> >>> +	priv = netdev_priv(dev);
> >>> +	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
> >>> +
> >>> +	priv->dev = dev;
> >>> +	priv->can.bittiming_const = &m_can_bittiming_const;
> >>> +	priv->can.do_set_mode = m_can_set_mode;
> >>> +	priv->can.do_get_berr_counter = m_can_get_berr_counter;
> >>> +	priv->can.ctrlmode_supported = CAN_CTRLMODE_LOOPBACK |
> >>> +					CAN_CTRLMODE_LISTENONLY |
> >>> +					CAN_CTRLMODE_BERR_REPORTING;
> >>
> >> Please take care of CAN_CTRLMODE_BERR_REPORTING, i.e. only enable bus
> >> the bus error interrupt if this bit is set.
> >>
> > 
> > Okay, BTW, does BERR_REPROTING includes lost message error?
> 
> The lost message interrupt should always be enabled and reported via a
> CAN error message.
> 
> Marc
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 


