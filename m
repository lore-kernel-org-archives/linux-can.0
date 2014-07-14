From: Dong Aisheng <b29396@freescale.com>
Subject: Re: [PATCH v3 1/2] can: m_can: add device tree binding
 documentation
Date: Mon, 14 Jul 2014 15:06:58 +0800
Message-ID: <20140714070657.GC1668@shlinux1.ap.freescale.net>
References: <1405074557-5519-1-git-send-email-b29396@freescale.com>
 <53BFDE68.4040405@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:50539
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751709AbaGNHLi (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 14 Jul 2014 03:11:38 -0400
Content-Disposition: inline
In-Reply-To: <53BFDE68.4040405@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org, wg@grandegger.com, socketcan@hartkopp.net, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, mark.rutland@arm.com, varkabhadram@gmail.com

On Fri, Jul 11, 2014 at 02:54:00PM +0200, Marc Kleine-Budde wrote:
> On 07/11/2014 12:29 PM, Dong Aisheng wrote:
> > add M_CAN device tree binding documentation
> > 
> > Cc: Wolfgang Grandegger <wg@grandegger.com>
> > Cc: Marc Kleine-Budde <mkl@pengutronix.de>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Oliver Hartkopp <socketcan@hartkopp.net>
> > Cc: Varka Bhadram <varkabhadram@gmail.com>
> > Signed-off-by: Dong Aisheng <b29396@freescale.com>
> > ---
> >  .../devicetree/bindings/net/can/m_can.txt          |   65 ++++++++++++++++++++
> >  1 files changed, 65 insertions(+), 0 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/m_can.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/m_can.txt b/Documentation/devicetree/bindings/net/can/m_can.txt
> > new file mode 100644
> > index 0000000..c4cb263
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/m_can.txt
> > @@ -0,0 +1,65 @@
> > +Bosch MCAN controller Device Tree Bindings
> > +-------------------------------------------------
> > +
> > +Required properties:
> > +- compatible		: Should be "bosch,m_can" for M_CAN controllers
> > +- reg			: physical base address and size of the M_CAN
> > +			  registers map and Message RAM
> > +- reg-names		: Should be "m_can" and "message_ram"
> > +- interrupts		: Should be the interrupt number of M_CAN interrupt
> > +			  line 0 and line 1, could be same if sharing
> > +			  the same interrupt.
> > +- interrupt-names	: Should contain "int0" and "int1"
> > +- clocks		: Clocks used by controller, should be host clock
> > +			  and CAN clock.
> > +- clock-names		: Should contain "hclk" and "cclk"
> > +- pinctrl-<n>		: Pinctrl states as described in bindings/pinctrl/pinctrl-bindings.txt
> > +- pinctrl-names		: Names corresponding to the numbered pinctrl states
> > +- mram-cfg		: Message RAM configuration data.
> > +  Multiple M_CAN instances can share the same Message RAM and each element(e.g
> > +  Rx FIFO or Tx Buffer and etc) number in Message RAM is also configurable,
> > +  so this property is telling driver how the shared or private Message RAM
> > +  are used by this M_CAN controller.
> 
> Will you have to modify the binding, espeically the mram-cfg, if you add
> canfd support to the driver?
> 

No need, CANFD in i.MX6SX is using the same IP of Bosch M_CAN.

> I think mram-cfg should have a vendor prefix, e.g.: bosch,mram-cfg
> 

It's a good idea.
Will update it.

> > +
> > +  The format should be as follows:
> > +  <offset sidf_elems xidf_elems rxf0_elems rxf1_elems rxb_elems
> > +   txe_elems txb_elems>
> > +  The 'offset' is an address offset of the Message RAM where the following
> > +  elements start from. This is usually set to 0x0 if you're using a private
> > +  Message RAM. The remain cells are used to specify how many elements are used
> > +  for each FIFO/Buffer.
> > +
> > +M_CAN includes the following elements according to user manual:
> > +11-bit Filter	0-128 elements / 0-128 words
> > +29-bit Filter	0-64 elements / 0-128 words
> > +Rx FIFO 0	0-64 elements / 0-1152 words
> > +Rx FIFO 1	0-64 elements / 0-1152 words
> > +Rx Buffers	0-64 elements / 0-1152 words
> > +Tx Event FIFO	0-32 elements / 0-64 words
> > +Tx Buffers	0-32 elements / 0-576 words
> > +
> > +Please refer to 2.4.1 Message RAM Configuration in Bosch M_CAN user manual
> > +for details.
> > +
> > +Example:
> > +SoC dtsi:
> > +m_can1: can@020e8000 {
> > +	compatible = "bosch,m_can";
> > +	reg = <0x020e8000 0x4000>, <0x02298000 0x4000>;
> > +	reg-names = "m_can", "message_ram";
> > +	interrupts = <0 114 0x04>,
> > +		     <0 114 0x04>;
> > +	interrupt-names = "int0", "int1";
> > +	clocks = <&clks IMX6SX_CLK_CANFD>,
> > +		 <&clks IMX6SX_CLK_CANFD>;
> > +	clock-names = "hclk", "cclk";
> > +	mram-cfg = <0x0 0 0 32 0 0 0 1>;
> > +	status = "disabled";
> > +};
> > +
> > +Board dtsi:
> > +&m_can1 {
> > +	pinctrl-names = "default";
> > +	pinctrl-0 = <&pinctrl_m_can1>;
> > +	status = "enabled";
> > +};
> > 
> 
> Marc
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 

Regards
Dong Aisheng
