From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] can: at91_can: add dt support
Date: Mon, 11 Mar 2013 16:39:56 +0100
Message-ID: <4097.59588442302$1363016445@news.gmane.org>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-2-git-send-email-ludovic.desroches@atmel.com>
 <513A2365.5050803@pengutronix.de>
 <20130311091722.GA2572@ludovic.desroches@atmel.com>
 <513DF46E.7000903@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <513DF46E.7000903-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Mon, Mar 11, 2013 at 04:12:46PM +0100, Marc Kleine-Budde wrote:
> On 03/11/2013 10:17 AM, Ludovic Desroches wrote:
> > On Fri, Mar 08, 2013 at 06:44:05PM +0100, Marc Kleine-Budde wrote:
> >> On 03/08/2013 06:30 PM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
> >>> From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> >>>
> >>> Add device tree support.
> >>>
> >>> Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
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
