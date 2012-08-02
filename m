From: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 0/3] Add DT support to C_CAN/D_CAN controller
Date: Thu, 2 Aug 2012 18:43:08 +0530
Message-ID: <1343913191-14722-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
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
To: wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org, mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-can-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, anantgole-l0cyMroinI0@public.gmane.org
List-Id: linux-can.vger.kernel.org

This patch series adds the device tree support and Runtime PM support
to C_CAN/D_CAN controller. First patch cleans up the device names used
in c_can driver.

These patches have been tested on AM335x EVM using some additional
patches to add device tree data to EVM dts files and to initialize
D_CAN RAM. D_CAN raminit is controlled from control module register.
This patch will be submitted once control module MFD driver support
is added. And these patches are based on linx-can-next tree.

Due to lack of hardware I am not able to test c_can functionality.
I appreciate if anyone can test c_can functionality with this patch
series.

Changes from v3:
	- Changed the patch sequence

Changes from v2:
	- Incorporated Marcs on v2
	  * Fix compilation errors in pci due to device name changes
	  in v2 by adding new patch.

Changes from v1:
	- Separated 4 patches into CAN driver specific and device
	  tree data addition specific.
	- Incorporated Marc's comments on v1
	  * Modified c_can_dev_id enum to handle both devtype and
	    platform device id index.
	  * Removed "legacy bosch,c_can_platform" from DT bindings

AnilKumar Ch (3):
  can: c_can: Modify c_can device names
  can: c_can: Add device tree support to Bosch C_CAN/D_CAN controller
  can: c_can: Add runtime PM support to Bosch C_CAN/D_CAN controller

 .../devicetree/bindings/net/can/c_can.txt          |   37 +++++++++++
 drivers/net/can/c_can/c_can.h                      |    5 +-
 drivers/net/can/c_can/c_can_pci.c                  |    6 +-
 drivers/net/can/c_can/c_can_platform.c             |   65 +++++++++++++++-----
 4 files changed, 91 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/can/c_can.txt

-- 
1.7.9.5
