From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4.3] peak_pci: add support for PEAK-System
 PCIe/PCIeC/miniPCI cards
Date: Fri, 03 Feb 2012 11:44:28 +0100
Message-ID: <4F2BBA8C.3020501@peak-system.com>
References: <1328188792-2982-1-git-send-email-s.grosjean@peak-system.com>
 <4F2ACFE9.3080602@hartkopp.net> <4F2B16F9.8020903@hartkopp.net>
 <4F2BB498.60606@grandegger.com>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:45722 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755921Ab2BCKoj (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 05:44:39 -0500
In-Reply-To: <4F2BB498.60606@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, linux-can Mailing List <linux-can@vger.kernel.org>

Le 03/02/2012 11:19, Wolfgang Grandegger a =E9crit :
> On 02/03/2012 12:06 AM, Oliver Hartkopp wrote:
>> On 02.02.2012 19:03, Oliver Hartkopp wrote:
>>
>>
>> The problem is that the PCAN-ExpressCards without galvanic isolation
>> (IPEH-003000, IPEH-003001) are not working at all when the I2C stuff=
 is not
>> initialized.
> If that is true...

Yes this is true but for PCAN-ExpressCard without galvanic isolation=20
only, that is, PCAN-ExpressCard with galvanic isolation won't need I2C=20
stuff..

> What about this:
>
>   config CAN_PEAK_PCI
> 	tristate "PEAK PCAN-PCI/PCIe/miniPCI Cards"
> 	depends on PCI
> 	---help---
> 	  This driver is for the PCAN PCI/PCIe cards (1, 2, 3 or 4 channels)
> 	  from PEAK Systems (http://www.peak-system.com).
> 	  This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
> 	  (1, 2, 3 or 4 channels) from PEAK-System Technik
> 	  (http://www.peak-system.com).
>
> 	  The I2C bit-banging algorithm (I2C ALGOBIT) needs to be selected t=
o
> 	  support PCAN-ExpressCard (PCIeC) cards.
>
>
>    config CAN_PEAK_PCIEC
>   	bool "PEAK PCAN-Express Cards"
>   	depends on CAN_PEAK_PCI&&  I2C_ALGOBIT
>   	default y

So, I think that the following is closer to the truth:

  config CAN_PEAK_PCI
-	tristate "PEAK PCAN-PCI/PCIe/miniPCI Cards"
+	tristate "PEAK PCAN-PCI/PCIe/PCIeC/miniPCI Cards"
	depends on PCI
	---help---
	  This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
	  (1, 2, 3 or 4 channels) from PEAK-System Technik
	  (http://www.peak-system.com).

	  The I2C bit-banging algorithm (I2C ALGOBIT) needs to be selected to
-	  support PCAN-ExpressCard (PCIeC) cards.
+	  support PCAN-ExpressCard cards models without galvanic isolation
+ 	  that is, IPEH-003000 and IPEH-003001.

  config CAN_PEAK_PCIEC_I2C
+ 	bool "PEAK non-isolated PCAN-ExpressCard Cards"
  	depends on CAN_PEAK_PCI&&  I2C_ALGOBIT
  	default y
+	---help---
+        Say Y here if your PEAK-System Technik PCAN-ExpressCard is not=
 equipped
+        with any galvanic isolation (IPEH-003000 and IPEH-003001)  .


(sorry for the manual-made patch style)

St=E9phane
--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
