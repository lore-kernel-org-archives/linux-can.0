From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v4 3/3] can: c_can: Add runtime PM support to Bosch
 C_CAN/D_CAN controller
Date: Tue, 7 Aug 2012 10:39:47 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA0D2EF@DBDE01.ent.ti.com>
References: <1343913191-14722-1-git-send-email-anilkumar@ti.com>
 <1343913191-14722-4-git-send-email-anilkumar@ti.com>
 <79CD15C6BA57404B839C016229A409A83EA7F150@DBDE01.ent.ti.com>
 <501C21E5.9080106@pengutronix.de>
 <79CD15C6BA57404B839C016229A409A83EA85CC3@DBDE01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA85CC3-Er742YJ7I/eIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
To: "Hiremath, Vaibhav" <hvaibhav-l0cyMroinI0@public.gmane.org>, Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "Gole,
 Anant" <anantgole-l0cyMroinI0@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Vaibhav,

Thanks for the review.

On Mon, Aug 06, 2012 at 12:18:32, Hiremath, Vaibhav wrote:
> On Sat, Aug 04, 2012 at 00:39:25, Marc Kleine-Budde wrote:
> > On 08/03/2012 08:32 AM, Hiremath, Vaibhav wrote:
> > > On Thu, Aug 02, 2012 at 18:43:11, AnilKumar, Chimata wrote:
> > >> Add Runtime PM support to C_CAN/D_CAN controller. The runtime PM
> > >> APIs control clocks for C_CAN/D_CAN IP and prevent access to the
> > >> register of C_CAN/D_CAN IP when clock is turned off.
> > >>
> > >> Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> > >> ---
> > >>  drivers/net/can/c_can/c_can_platform.c |    8 ++++++++
> > >>  1 file changed, 8 insertions(+)
> > >>
> > >> diff --git a/drivers/net/can/c_can/c_can_platform.c b/drivers/net/can/c_can/c_can_platform.c
> > >> index d0a66cf..83a1e17 100644
> > >> --- a/drivers/net/can/c_can/c_can_platform.c
> > >> +++ b/drivers/net/can/c_can/c_can_platform.c
> > >> @@ -32,6 +32,7 @@
> > >>  #include <linux/clk.h>
> > >>  #include <linux/of.h>
> > >>  #include <linux/of_device.h>
> > >> +#include <linux/pm_runtime.h>
> > >>  
> > >>  #include <linux/can/dev.h>
> > >>  
> > >> @@ -177,6 +178,9 @@ static int __devinit c_can_plat_probe(struct platform_device *pdev)
> > >>  		goto exit_free_device;
> > >>  	}
> > >>  
> > >> +	pm_runtime_enable(&pdev->dev);
> > >> +	pm_runtime_get_sync(&pdev->dev);
> > >> +
> > > 
> > > If module is inserted or built into the kernel, module stays in enabled 
> > > state always, isn't that wrong?
> > > Ideally, you should enable the module when it is required or being used.
> > 
> > Good point.
> > 
> > If you don't access the module's registers in the probe- (or its
> > subroutines) it should be enough to enable the module in the open()
> > function. Have a look at clk_prepare_enable / clk_disable_unprepare in
> > the flexcan driver.
> > 
> 
> Yeah Marc, something similar, above runtime pm api's should be moved to 
> open-n-close.
> 

Not all APIs, only *_get_sync and *_put_sync to appropriate positions.
I will send next version after fixing this.

Regards
AnilKumar
