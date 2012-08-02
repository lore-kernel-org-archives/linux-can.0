From: "AnilKumar, Chimata" <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH v3 0/3] Add DT support to C_CAN/D_CAN controller
Date: Thu, 2 Aug 2012 11:39:13 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA081FB@DBDE01.ent.ti.com>
References: <1343905339-4642-1-git-send-email-anilkumar@ti.com>
 <501A60C0.1040504@pengutronix.de>
 <331ABD5ECB02734CA317220B2BBEABC13EA081AD@DBDE01.ent.ti.com>
 <501A633A.5000100@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <501A633A.5000100-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
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

On Thu, Aug 02, 2012 at 16:53:38, Marc Kleine-Budde wrote:
> On 08/02/2012 01:21 PM, AnilKumar, Chimata wrote:
> > Marc,
> > 
> > On Thu, Aug 02, 2012 at 16:43:04, Marc Kleine-Budde wrote:
> >> On 08/02/2012 01:02 PM, AnilKumar Ch wrote:
> >>> This patch series adds the device tree support and Runtime PM support
> >>> to C_CAN/D_CAN controller.
> >>>
> >>> These patches have been tested on AM335x EVM using some additional
> >>> patches to add device tree data to EVM dts files and to initialize
> >>> D_CAN RAM. D_CAN raminit is controlled from control module register.
> >>> This patch will be submitted once control module MFD driver support
> >>> is added.
> >>>
> >>> These patches are based on linx-can-next tree.
> >>>
> >>> Due to lack of hardware I am not able to test c_can functionality.
> >>> I appreciate if anyone can test c_can functionality with this patch
> >>> series.
> >>>
> >>> Changes from v2:
> >>> 	- Incorporated Marcs on v2
> >>> 	  * Fix compilation errors in pci due to device name changes
> >>> 	  in v2 by adding new patch.
> >>>
> >>> Changes from v1:
> >>> 	- Separated 4 patches into CAN driver specific and device
> >>> 	  tree data addition specific.
> >>> 	- Incorporated Marc's comments on v1
> >>> 	  * Modified c_can_dev_id enum to handle both devtype and
> >>> 	    platform device id index.
> >>> 	  * Removed "legacy bosch,c_can_platform" from DT bindings
> >>>
> >>> AnilKumar Ch (3):
> >>>   can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
> >>>   can: c_can: Modify c_can device names in c_can_pci driver
> >>
> >> You break bisectability here. After patch 1 the pci driver will not
> >> compile anymore. I suggest to do the renaming of enum c_can_dev_id and
> >> all it's users in patch 1.
> >>
> > 
> > I will merge patch 1 and 2 and submit v4.
> 
> But changing the pci driver has nothing to do with the subject ("Add
> device tree support to Bosch C_CAN/D_CAN controller").
> 
> It's considered bad practise to do so.
> 

In that case I will change the patch 1 according to "C_CAN_PLTFORM_DEVTYPE"
and flag name changes to BOSCH_* will be in patch 2. So that we can get rid
of these two problems.

Regards
AnilKumar
