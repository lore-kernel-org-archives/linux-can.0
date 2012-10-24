From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH] can/sja1000: Add miniPCIe/cPCI PC/104Plus PCI/104e PEAK-System
 boards
Date: Wed, 24 Oct 2012 08:29:45 +0200
Message-ID: <50878AD9.6070302@grandegger.com>
References: <1350988637-13581-1-git-send-email-s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:33410 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933419Ab2JXG3s (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Oct 2012 02:29:48 -0400
In-Reply-To: <1350988637-13581-1-git-send-email-s.grosjean@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Hi Stephane,

On 10/23/2012 12:37 PM, Stephane Grosjean wrote:
> This patch adds the support for 4 new PCI boards based on the SJA1000 CAN
> controller, from PEAK-System Technik:
> 
> . PCAN-miniPCIe (PCI-Express Mini slots, available as single or dual-channel)
> . PCAN-cPCI (CompactPCI format, available as single or dual-channel)
> . PCAN-PC/104-Plus (PC/104-Plus system, av. as 1, 2 or 4 channels)
> . PCAN-PCI/104-Express (PCI/104-Express system, av. as 1 or 2 channels)
> 
> This patch also fixes a typo in existing "PEAK_MPCI_DEVICE_ID" identifier
> (missing "E" for Express). Finally, it also adds another author as well as it
> updates the module supported devices list.
> 
> Signed-off-by: Stephane Grosjean <s.grosjean@peak-system.com>
> ---
>  drivers/net/can/sja1000/peak_pci.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja1000/peak_pci.c
> index f0a1296..15a302e 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
> @@ -31,8 +31,10 @@
>  #include "sja1000.h"
>  
>  MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
> +MODULE_AUTHOR("Stephane Grosjean <s.grosjean@peak-system.com>");

Hm, does adding a second MODULE_AUTHOR work? Anyway, feel free to remove
my line.

>  MODULE_DESCRIPTION("Socket-CAN driver for PEAK PCAN PCI family cards");
>  MODULE_SUPPORTED_DEVICE("PEAK PCAN PCI/PCIe/PCIeC miniPCI CAN cards");
> +MODULE_SUPPORTED_DEVICE("PEAK PCAN miniPCIe/cPCI PC/104+ PCI/104e CAN Cards");
>  MODULE_LICENSE("GPL v2");
>  
>  #define DRV_NAME  "peak_pci"
> @@ -64,7 +66,11 @@ struct peak_pci_chan {
>  #define PEAK_PCI_DEVICE_ID	0x0001	/* for PCI/PCIe slot cards */
>  #define PEAK_PCIEC_DEVICE_ID	0x0002	/* for ExpressCard slot cards */
>  #define PEAK_PCIE_DEVICE_ID	0x0003	/* for nextgen PCIe slot cards */
> -#define PEAK_MPCI_DEVICE_ID	0x0008	/* The miniPCI slot cards */
> +#define PEAK_CPCI_DEVICE_ID	0x0004	/* for nextgen cPCI slot cards */
> +#define PEAK_MPCI_DEVICE_ID	0x0005	/* for nextgen miniPCI slot cards */
> +#define PEAK_PC_104P_DEVICE_ID	0x0006	/* PCAN-PC/104+ cards */
> +#define PEAK_PCI_104E_DEVICE_ID	0x0007	/* PCAN-PCI/104 Express cards */
> +#define PEAK_MPCIE_DEVICE_ID	0x0008	/* The miniPCIe slot cards */
>  
>  #define PEAK_PCI_CHAN_MAX	4
>  
> @@ -76,6 +82,10 @@ static DEFINE_PCI_DEVICE_TABLE(peak_pci_tbl) = {
>  	{PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
>  	{PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
>  	{PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
> +	{PEAK_PCI_VENDOR_ID, PEAK_MPCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
> +	{PEAK_PCI_VENDOR_ID, PEAK_PC_104P_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
> +	{PEAK_PCI_VENDOR_ID, PEAK_PCI_104E_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
> +	{PEAK_PCI_VENDOR_ID, PEAK_CPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
>  #ifdef CONFIG_CAN_PEAK_PCIEC
>  	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,},
>  #endif

Acked-by: Wolfgang Grandegger <wg@grandegger.com>

Thanks,

Wolfgang.


