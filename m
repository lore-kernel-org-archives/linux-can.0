From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 3/3] can: Kconfig: CAN_AT91 depends on ARCH_AT91
Date: Mon, 11 Mar 2013 10:24:19 +0100
Message-ID: <3115.55997836894$1362993916@news.gmane.org>
References: <1362763842-14924-1-git-send-email-ludovic.desroches@atmel.com>
 <1362763842-14924-4-git-send-email-ludovic.desroches@atmel.com>
 <513A2396.4080508@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <513A2396.4080508@pengutronix.de>
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
Cc: plagnioj@jcrosoft.com, devicetree-discuss@lists.ozlabs.org, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, linux-can@vger.kernel.org
List-Id: linux-can.vger.kernel.org

On Fri, Mar 08, 2013 at 06:44:54PM +0100, Marc Kleine-Budde wrote:
> On 03/08/2013 06:30 PM, ludovic.desroches@atmel.com wrote:
> > From: Ludovic Desroches <ludovic.desroches@atmel.com>
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
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
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
