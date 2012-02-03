From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4.3] peak_pci: add support for PEAK-System
 PCIe/PCIeC/miniPCI cards
Date: Fri, 03 Feb 2012 13:01:19 +0100
Message-ID: <4F2BCC8F.1060402@peak-system.com>
References: <1328188792-2982-1-git-send-email-s.grosjean@peak-system.com>
 <4F2ACFE9.3080602@hartkopp.net> <4F2B16F9.8020903@hartkopp.net>
 <4F2BB498.60606@grandegger.com> <4F2BBA8C.3020501@peak-system.com>
 <4F2BBE24.5090601@grandegger.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:33578 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2BCMB3 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 07:01:29 -0500
In-Reply-To: <4F2BBE24.5090601@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Le 03/02/2012 11:59, Wolfgang Grandegger a =E9crit :
>
> I mean, no support for the PCIEC
> if CAN_PEAK_PCIEC is not enabled.

=2E.. Hmm: I don't know how to do that without adding another=20
#ifdef/#endif block in the pci devices table:

static DEFINE_PCI_DEVICE_TABLE(peak_pci_tbl) =3D {
         {PEAK_PCI_VENDOR_ID, PEAK_PCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_I=
D,},
         {PEAK_PCI_VENDOR_ID, PEAK_PCIE_DEVICE_ID, PCI_ANY_ID, PCI_ANY_=
ID,},
         {PEAK_PCI_VENDOR_ID, PEAK_MPCI_DEVICE_ID, PCI_ANY_ID, PCI_ANY_=
ID,},
+#ifdef CONFIG_CAN_PEAK_PCIEC
         {PEAK_PCI_VENDOR_ID, PEAK_PCIEC_DEVICE_ID, PCI_ANY_ID,=20
PCI_ANY_ID,},
+#endif
         {0,}
};

I think that other blocks could be handled using Marc proposal (#define=
=20
peak_pciec_leds() (0) or (1)).

Will this be ok?

St=E9phane



--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
