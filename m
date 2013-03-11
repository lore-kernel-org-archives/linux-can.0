From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] can: Kconfig: CAN_AT91 depends on ARCH_AT91
Date: Mon, 11 Mar 2013 10:24:19 +0100
Message-ID: <15079.1107131683$1362993897@news.gmane.org>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-4-git-send-email-ludovic.desroches@atmel.com>
 <513A2396.4080508@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <513A2396.4080508-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-can.vger.kernel.org

On Fri, Mar 08, 2013 at 06:44:54PM +0100, Marc Kleine-Budde wrote:
> On 03/08/2013 06:30 PM, ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org wrote:
> > From: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> > 
> > SAMA5D3 devices also embed CAN feature. Moreover if we want to produce a single
> > kernel image (at least for Atmel devices) it is not useful to be too
> > restrictive.
> 
> If it compiles on other ARMs aswell we can make it depend on ARCH_ARM.
> 

I was thinking about it but I am wondering if it makes sense. Should we have a
non atmel device with atmel can?

I have no position about this point, if you think it's better to make it depending onto ARCH_ARM, I'll change it if there is no compilation issue.

Regards

Ludovic

> Marc
> > 
> > Signed-off-by: Ludovic Desroches <ludovic.desroches-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
> > ---
> >  drivers/net/can/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
> > index 9862b2e..27311c3 100644
> > --- a/drivers/net/can/Kconfig
> > +++ b/drivers/net/can/Kconfig
> > @@ -65,7 +65,7 @@ config CAN_LEDS
> >  
> >  config CAN_AT91
> >  	tristate "Atmel AT91 onchip CAN controller"
> > -	depends on ARCH_AT91SAM9263 || ARCH_AT91SAM9X5
> > +	depends on ARCH_AT91
> >  	---help---
> >  	  This is a driver for the SoC CAN controller in Atmel's AT91SAM9263
> >  	  and AT91SAM9X5 processors.
> > 
> 
> 
> -- 
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |
> 
