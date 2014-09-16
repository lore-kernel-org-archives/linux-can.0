From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH can] peak_pci: add PCI ID definition pcie card variant
Date: Tue, 16 Sep 2014 15:05:18 +0200
Message-ID: <5418358E.1060506@peak-system.com>
References: <5417EF55.9050805@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:43899 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753383AbaIPNF0 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 16 Sep 2014 09:05:26 -0400
In-Reply-To: <5417EF55.9050805@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Oliver,

You've got my Acked-by, many thanks for having handled that !

Le 16/09/2014 10:05, Oliver Hartkopp a =E9crit :
> Add PCI ID definition for the single channel PCAN ExpressCard 34 adap=
ter.
> Due to the subsystem id evaluation the correct number of channels (he=
re 1)
> is created at initialization time. Tested including the LED functiona=
lity.
>
> Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
> CC: Stephane Grosjean <s.grosjean@peak-system.com>
Acked-by: Stephane Grosjean <s.grosjean@peak-system.com>
>
> ---
>
> Hi Marc,
>
> as this is 'just a PCI ID definition' this patch should go into Daves
> net-tree for 3.17-rc upstream. The USB guys do it the same as there i=
s no
> risk of breaking other peoples work at that stage.
>
> Tnx,
> Oliver
>
>
>
> diff --git a/drivers/net/can/sja1000/peak_pci.c b/drivers/net/can/sja=
1000/peak_pci.c
> index 7a85590..e5fac36 100644
> --- a/drivers/net/can/sja1000/peak_pci.c
> +++ b/drivers/net/can/sja1000/peak_pci.c
> @@ -70,6 +70,8 @@ struct peak_pci_chan {
>   #define PEAK_PC_104P_DEVICE_ID	0x0006	/* PCAN-PC/104+ cards */
>   #define PEAK_PCI_104E_DEVICE_ID	0x0007	/* PCAN-PCI/104 Express card=
s */
>   #define PEAK_MPCIE_DEVICE_ID	0x0008	/* The miniPCIe slot cards */
> +#define PEAK_PCIE_OEM_ID	0x0009	/* PCAN-PCI Express OEM */
> +#define PEAK_PCIEC34_DEVICE_ID	0x000A	/* PCAN-PCI Express 34 (one ch=
annel) */
>  =20
>   #define PEAK_PCI_CHAN_MAX	4
>  =20
> @@ -87,6 +89,7 @@ static const struct pci_device_id peak_pci_tbl[] =3D=
 {
>   	{PEAK_PCI_VENDOR_ID, PEAK_CPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,}=
,
>   #ifdef CONFIG_CAN_PEAK_PCIEC
>   	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID,=
},
> +	{PEAK_PCI_VENDOR_ID, PEAK_PCIEC34_DEVICE_ID, PCI_ANY_ID, PCI_ANY_ID=
,},
>   #endif
>   	{0,}
>   };
> @@ -653,7 +656,8 @@ static int peak_pci_probe(struct pci_dev *pdev, c=
onst struct pci_device_id *ent)
>   		 * This must be done *before* register_sja1000dev() but
>   		 * *after* devices linkage
>   		 */
> -		if (pdev->device =3D=3D PEAK_PCIEC_DEVICE_ID) {
> +		if (pdev->device =3D=3D PEAK_PCIEC_DEVICE_ID ||
> +		    pdev->device =3D=3D PEAK_PCIEC34_DEVICE_ID) {
>   			err =3D peak_pciec_probe(pdev, dev);
>   			if (err) {
>   				dev_err(&pdev->dev,
>
>
>

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
--
