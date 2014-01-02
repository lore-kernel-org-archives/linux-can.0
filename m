From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can: sja1000: add support for Elcus CAN200PCI
Date: Thu, 02 Jan 2014 15:19:09 +0100
Message-ID: <52C5755D.8050302@hartkopp.net>
References: <52BF20F4.1090404@mcc.vniiem.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:47518 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbaABOTL (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 2 Jan 2014 09:19:11 -0500
In-Reply-To: <52BF20F4.1090404@mcc.vniiem.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oleg Moroz <oleg.moroz@mcc.vniiem.ru>
Cc: linux-can@vger.kernel.org

Hello Oleg,

linux/scripts/checkpatch.pl still points out some problems:

' might be better as 'Oleg Moroz <oleg.moroz@mcc.vniiem.ru>>
#4:
Signed-off-by: Oleg Moroz<oleg.moroz@mcc.vniiem.ru>

=> there was a space missing :-)

ERROR: DOS line endings
#16: FILE: drivers/net/can/sja1000/plx_pci.c:48:
+^I^I^I"IXXAT PC-I 04/PCI, "^M$

Ugh!

Don't use DOS line endings with CR/LF.
Unix is only LF (\n)

Please repost.

Thanks,
Oliver


On 28.12.2013 20:05, Oleg Moroz wrote:
> This patch adds support for Elcus CAN200PCI card.
> 
> Signed-off-by: Oleg Moroz<oleg.moroz@mcc.vniiem.ru>
> 
> ---
> 
> diff -u a/drivers/net/can/sja1000/plx_pci.c b/drivers/net/can/sja1000/plx_pci.c
> --- a/drivers/net/can/sja1000/plx_pci.c
> +++ b/drivers/net/can/sja1000/plx_pci.c
> @@ -45,7 +45,8 @@ MODULE_SUPPORTED_DEVICE("Adlink PCI-7841
>              "esd CAN-PCI/PMC/266, "
>              "esd CAN-PCIe/2000, "
>              "Connect Tech Inc. CANpro/104-Plus Opto (CRG001), "
> -            "IXXAT PC-I 04/PCI")
> +            "IXXAT PC-I 04/PCI, "
> +            "ELCUS CAN-200-PCI")
>  MODULE_LICENSE("GPL v2");
>  
>  #define PLX_PCI_MAX_CHAN 2
> @@ -123,6 +124,11 @@ struct plx_pci_card {
>  #define ESD_PCI_SUB_SYS_ID_PCIE2000    0x0200
>  #define ESD_PCI_SUB_SYS_ID_PCI104200    0x0501
>  
> +#define CAN200PCI_DEVICE_ID        0x9030
> +#define CAN200PCI_VENDOR_ID        0x10b5
> +#define CAN200PCI_SUB_DEVICE_ID        0x0301
> +#define CAN200PCI_SUB_VENDOR_ID        0xe1c5
> +
>  #define IXXAT_PCI_VENDOR_ID        0x10b5
>  #define IXXAT_PCI_DEVICE_ID        0x9050
>  #define IXXAT_PCI_SUB_SYS_ID        0x2540
> @@ -234,6 +240,14 @@ static struct plx_pci_card_info plx_pci_
>      /* based on PLX9030 */
>  };
>  
> +static struct plx_pci_card_info plx_pci_card_info_elcus = {
> +    "Eclus CAN-200-PCI", 2,
> +    PLX_PCI_CAN_CLOCK, PLX_PCI_OCR, PLX_PCI_CDR,
> +    {1, 0x00, 0x00}, { {2, 0x00, 0x80}, {3, 0x00, 0x80} },
> +    &plx_pci_reset_common
> +    /* based on PLX9030 */
> +};
> +
>  static DEFINE_PCI_DEVICE_TABLE(plx_pci_tbl) = {
>      {
>          /* Adlink PCI-7841/cPCI-7841 */
> @@ -319,6 +333,13 @@ static DEFINE_PCI_DEVICE_TABLE(plx_pci_t
>          0, 0,
>          (kernel_ulong_t)&plx_pci_card_info_cti
>      },
> +    {
> +        /* Elcus CAN-200-PCI */
> +        CAN200PCI_VENDOR_ID, CAN200PCI_DEVICE_ID,
> +        CAN200PCI_SUB_VENDOR_ID, CAN200PCI_SUB_DEVICE_ID,
> +        0, 0,
> +        (kernel_ulong_t)&plx_pci_card_info_elcus
> +    },
>      { 0,}
>  };
>  MODULE_DEVICE_TABLE(pci, plx_pci_tbl);
> 
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
