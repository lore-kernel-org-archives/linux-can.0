From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v2 1/2] can: c_can: Add device tree support to Bosch
 C_CAN/D_CAN controller
Date: Thu, 2 Aug 2012 08:51:06 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA0802C@DBDE01.ent.ti.com>
References: <1343218729-16954-1-git-send-email-anilkumar@ti.com>
 <1343218729-16954-2-git-send-email-anilkumar@ti.com>
 <500FF908.1000307@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA037AA@DBDE01.ent.ti.com>
 <501A3370.5090906@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <501A3370.5090906-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

Hi Marc,

On Thu, Aug 02, 2012 at 13:29:44, Marc Kleine-Budde wrote:
> On 07/25/2012 04:12 PM, AnilKumar, Chimata wrote:
> > Marc,
> > 
> > On Wed, Jul 25, 2012 at 19:17:52, Marc Kleine-Budde wrote:
> >> On 07/25/2012 02:18 PM, AnilKumar Ch wrote:
> >>> Add device tree support to C_CAN/D_CAN controller and usage details
> >>> are added to device tree documentation. Driver was tested on AM335x
> >>> EVM.
> >>
> >> Does not apply to linux-can-next, as Viresh Kumar's patch "net/c_can:
> >> remove conditional compilation of clk code" is not yet included. I
> >> suggest to delay this patch until we have Viresh's patch in net-next.
> >>
> >> See comment inline.
> > 
> > Ok, I will wait till net-next is updated with Viresh Kumar's patch.
> 
> Now Viresh's patch is in net-next, feel free to post your new patches.

I will send the patches.

Thanks
AnilKumar
