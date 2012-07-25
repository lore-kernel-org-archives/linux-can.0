From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 1/2] can: c_can: Add device tree support to Bosch
 C_CAN/D_CAN controller
Date: Wed, 25 Jul 2012 14:12:22 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA037AA@DBDE01.ent.ti.com>
References: <1343218729-16954-1-git-send-email-anilkumar@ti.com>
 <1343218729-16954-2-git-send-email-anilkumar@ti.com>
 <500FF908.1000307@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <500FF908.1000307-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Gole,
 Anant" <anantgole-l0cyMroinI0@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Marc,

On Wed, Jul 25, 2012 at 19:17:52, Marc Kleine-Budde wrote:
> On 07/25/2012 02:18 PM, AnilKumar Ch wrote:
> > Add device tree support to C_CAN/D_CAN controller and usage details
> > are added to device tree documentation. Driver was tested on AM335x
> > EVM.
> 
> Does not apply to linux-can-next, as Viresh Kumar's patch "net/c_can:
> remove conditional compilation of clk code" is not yet included. I
> suggest to delay this patch until we have Viresh's patch in net-next.
> 
> See comment inline.

Ok, I will wait till net-next is updated with Viresh Kumar's patch.

> 
> > Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> > ---
> >  .../devicetree/bindings/net/can/c_can.txt          |   37 +++++++++++++
> >  drivers/net/can/c_can/c_can.h                      |    5 +-
> >  drivers/net/can/c_can/c_can_platform.c             |   57 ++++++++++++++------
> >  3 files changed, 80 insertions(+), 19 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/net/can/c_can.txt b/Documentation/devicetree/bindings/net/can/c_can.txt
> > new file mode 100644
> > index 0000000..dc4aec5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/can/c_can.txt
> > @@ -0,0 +1,37 @@
> > +Bosch C_CAN/D_CAN controller Device Tree Bindings
> > +-------------------------------------------------
> > +
> > +Required properties:
> > +- compatible		: Should be "bosch,c_can" for C_CAN controllers and
> > +			  "bosch,d_can" for D_CAN controllers.
> > +- reg			: physical base address and size of the C_CAN/D_CAN
> > +			  registers map
> > +- interrupts		: property with a value describing the interrupt
> > +			  number
> > +- interrupt-parent	: The parent interrupt controller
> > +
> > +Optional properties:
> > +- ti,hwmods		: Must be "d_can<n>" or "c_can<n>", n being the
> > +			  instance number
> > +
> > +Note: "ti,hwmods" field is used to fetch the base address and irq
> > +resources from TI, omap hwmod data base during device registration.
> > +Future plan is to migrate hwmod data base contents into device tree
> > +blob so that, all the required data will be used from device tree dts
> > +file.
> > +
> > +Examples:
> > +
> > +	d_can@481D0000 {
> > +		compatible = "bosch,d_can";
> > +		reg = <0x481D0000 0x1000>;
> > +		interrupts = <55 0x4>;
> > +		interrupt-parent = <&intc>;
> > +	};
> > +
> > +(or)
> > +
> > +	d_can@481D0000 {
> > +		compatible = "bosch,d_can";
> > +		ti,hwmods = "d_can1";
> > +	};
> > diff --git a/drivers/net/can/c_can/c_can.h b/drivers/net/can/c_can/c_can.h
> > index 01a7049..4e56baa 100644
> > --- a/drivers/net/can/c_can/c_can.h
> > +++ b/drivers/net/can/c_can/c_can.h
> > @@ -143,8 +143,9 @@ static const u16 reg_map_d_can[] = {
> >  };
> >  
> >  enum c_can_dev_id {
> > -	C_CAN_DEVTYPE,
> > -	D_CAN_DEVTYPE,
> > +	BOSCH_C_CAN_PLATFORM,
> > +	BOSCH_C_CAN,
> > +	BOSCH_D_CAN,
> 
> Note: these symbols are used in "drivers/net/can/c_can/c_can_pci.c", too.
> 

Oops! I missed out. Separate patch will be added in v3 with this series to take
care of this issue.

Regards
AnilKumar
