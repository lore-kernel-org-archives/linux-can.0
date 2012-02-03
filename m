From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH v4.3] peak_pci: add support for PEAK-System
 PCIe/PCIeC/miniPCI cards
Date: Fri, 03 Feb 2012 11:14:49 +0100
Message-ID: <4F2BB399.9000802@peak-system.com>
References: <1328188792-2982-1-git-send-email-s.grosjean@peak-system.com>
 <4F2ACFE9.3080602@hartkopp.net> <4F2B16F9.8020903@hartkopp.net>
Reply-To: Stephane Grosjean <s.grosjean@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:41911 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199Ab2BCKO7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 05:14:59 -0500
In-Reply-To: <4F2B16F9.8020903@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Le 03/02/2012 00:06, Oliver Hartkopp a =E9crit :
> On 02.02.2012 19:03, Oliver Hartkopp wrote:
>
>> The problem is that the PCAN-ExpressCards without galvanic isolation
>> (IPEH-003000, IPEH-003001) are not working at all when the I2C stuff=
 is not
>> initialized.
>>
>> It's not only the LED handling.

Yes you're right: the existing code already enables the can transceiver=
,=20
but I forgot that it used a led pin, sorry.

>> Alternatively you may just select I2C and I2C_ALGOBIT as it is done =
by other
>> drivers like this:
>>
>> http://lxr.linux.no/#linux+v3.2.2/drivers/net/ethernet/sfc/Kconfig#L=
7
>>
>> config CAN_PEAK_PCI
>> 	tristate "PEAK PCAN-PCI/PCIe/PCIeC/miniPCI Cards"
>> 	depends on PCI
>> 	select I2C
>> 	select I2C_ALGOBIT
>> 	---help---
>> 	  This driver is for the PCAN-PCI/PCIe/PCIeC/miniPCI cards
>> 	  (1, 2, 3 or 4 channels) from PEAK-System Technik
>> 	  (http://www.peak-system.com).
>>
>> ... which would also make the #ifdef stuff obsolete.

Well, if this is used in an already existing driver, we can suppose tha=
t=20
this is the correct way to do that.
I personally prefer the "select" way of doing things rather than the=20
"depends on".

Do someone disagree with?

Moreover, no response about my question of yesterday: since I have to=20
post another (pcmcia) driver for the sja1000 subdir (and thus, change=20
the Kconfig again), the best solution would be to post all through a=20
serie of patches, wouldn't it?

Thanks for your reply,

St=E9phane

--
PEAK-System Technik GmbH, Otto-Roehm-Strasse 69, D-64293 Darmstadt=20
Geschaeftsleitung: A.Gach/U.Wilhelm,St.Nr.:007/241/13586 FA Darmstadt=20
HRB-9183 Darmstadt, Ust.IdNr.:DE 202220078, WEE-Reg.-Nr.: DE39305391=20
Tel.+49 (0)6151-817320 / Fax:+49 (0)6151-817329, info@peak-system.com
