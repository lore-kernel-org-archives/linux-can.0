From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 1/3] can: at91_can: add dt support
Date: Mon, 11 Mar 2013 16:39:56 +0100
Message-ID: <25670.0509613895$1363016484@news.gmane.org>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-2-git-send-email-ludovic.desroches@atmel.com>
 <513A2365.5050803@pengutronix.de>
 <20130311091722.GA2572@ludovic.desroches@atmel.com>
 <513DF46E.7000903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <513DF46E.7000903@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, linux-can@vger.kernel.org, ludovic.desroches@atmel.com, plagnioj@jcrosoft.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-can.vger.kernel.org

On Mon, Mar 11, 2013 at 04:12:46PM +0100, Marc Kleine-Budde wrote:
> On 03/11/2013 10:17 AM, Ludovic Desroches wrote:
> > On Fri, Mar 08, 2013 at 06:44:05PM +0100, Marc Kleine-Budde wrote:
> >> On 03/08/2013 06:30 PM, ludovic.desroches@atmel.com wrote:
> >>> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>>
> >>> Add device tree support.
> >>>
> >>> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>> ---
> >>>  .../devicetree/bindings/net/can/atmel-can.txt      | 14 ++++
> >>>  drivers/net/can/at91_can.c                         | 75 ++++++++++++++++------
> >>>  2 files changed, 70 insertions(+), 19 deletions(-)
> >>>  create mode 100644 Documentation/devicetree/bindings/net/can/atmel-can.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/net/can/atmel-can.txt b/Documentation/devicetree/bindings/net/can/atmel-can.txt
> >>> new file mode 100644
> >>> index 0000000..69381db
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/net/can/atmel-can.txt
> >>> @@ -0,0 +1,14 @@
> >>> +* AT91 CAN *
> >>> +
> >>> +Required properties:
> >>> +  - compatible: Should be "atmel,at91sam9263-can" or "atmel,at91sam9x5-can"
> >>
> >> On imx we use the oldest SoC with that IP available. Which strategy are
> >> you following on at91?
> >>
> > 
> > We are using the same strategy.
> 
> But "atmel,at91sam9x5-can" isn't a specific SoC, probably a SoC family.
> Or are you using "atmel,at91sam9x5-can" for the other devices in the DT,
> too.
> 

You are right at91sam9x5 is not a specific SoC but a family of SoCs:
at91sam9g25, at91sam9g35, at91sam9x25 and at91sam9x35. This compatible string
is used for all the devices from and after the at91sam9x5 family: at91sam9n12,
samad3x, etc.

> I picked at91sam9x5-can for the non devicetree driver out of the blue,
> as there was no scheme established, yet. I'm not hanging on that name,
> I'd rather appreciate to follow the common at91 DT rules.

It follows at91 Dt rules, we have atmel,at91sam9x5-i2c, atmel,at91sam9x5-gpio
and others.

Regards

Ludovic
