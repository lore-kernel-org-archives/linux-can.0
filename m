From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v4.3] peak_pci: add support for PEAK-System PCIe/PCIeC/miniPCI
 cards
Date: Fri, 03 Feb 2012 13:28:50 +0100
Message-ID: <4F2BD302.7070803@grandegger.com>
References: <1328188792-2982-1-git-send-email-s.grosjean@peak-system.com> <4F2ACFE9.3080602@hartkopp.net> <4F2B16F9.8020903@hartkopp.net> <4F2BB498.60606@grandegger.com> <4F2BBA8C.3020501@peak-system.com> <4F2BBE24.5090601@grandegger.com> <4F2BCC8F.1060402@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:32995 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751058Ab2BCM2x (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 07:28:53 -0500
In-Reply-To: <4F2BCC8F.1060402@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

On 02/03/2012 01:01 PM, Stephane Grosjean wrote:
> Le 03/02/2012 11:59, Wolfgang Grandegger a =E9crit :
>>
>> I mean, no support for the PCIEC
>> if CAN_PEAK_PCIEC is not enabled.
>=20
> ... Hmm: I don't know how to do that without adding another
> #ifdef/#endif block in the pci devices table:
>=20
> static DEFINE_PCI_DEVICE_TABLE(peak_pci_tbl) =3D {
>         {PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_=
ID,},
>         {PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY=
_ID,},
>         {PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY=
_ID,},
> +#ifdef CONFIG_CAN_PEAK_PCIEC
>         {PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID,
> PCI_ANY_ID,},
> +#endif
>         {0,}
> };

=46ine for me! In principle the probe function could also just return
-ENODEV. BTW: s/peak_pciec_init/peak_pciec_probe/ would now be perfect.

Wolfgang.
