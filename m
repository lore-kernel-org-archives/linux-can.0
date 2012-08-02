From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 1/3] can: c_can: Add device tree support to Bosch
 C_CAN/D_CAN controller
Date: Thu, 2 Aug 2012 12:01:37 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA08249@DBDE01.ent.ti.com>
References: <1343905339-4642-1-git-send-email-anilkumar@ti.com>
 <1343905339-4642-2-git-send-email-anilkumar@ti.com>
 <3432187.NhmxBJqHyV@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <3432187.NhmxBJqHyV@wuerfel>
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
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Cc: "Nori, Sekhar" <nsekhar-l0cyMroinI0@public.gmane.org>, "mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, "Gole, Anant" <anantgole-l0cyMroinI0@public.gmane.org>, "linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-can.vger.kernel.org

Hi Arnd,

Thanks for the review

On Thu, Aug 02, 2012 at 17:03:59, Arnd Bergmann wrote:
> On Thursday 02 August 2012 16:32:17 AnilKumar Ch wrote:
> > +- interrupt-parent     : The parent interrupt controller
> > +
> > +Optional properties:
> > +- ti,hwmods            : Must be "d_can<n>" or "c_can<n>", n being the
> > +                         instance number
> 
> interrupt-parent should be optional, not mandatory. It's usually implied
> by the parent's interrupt-parent.
> 

In case of AM33XX specific we need to connect interrupt to interrupt
controller so I added to mandatory list. Yes I agree with you, in generic
case this should be optional I will change.

Thanks
AnilKumar
