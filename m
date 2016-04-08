From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] can/peak_pci: fix FPGA potential frame loss issue
Date: Fri, 8 Apr 2016 07:36:12 +0200
Message-ID: <5707434C.2050001@hartkopp.net>
References: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
 <569F9588.2090809@pengutronix.de> <569F99BE.70001@peak-system.com>
 <569F9AC5.6020706@pengutronix.de> <56A11AB2.5060200@hartkopp.net>
 <56A1F1FC.5070402@peak-system.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:48094 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbcDHFgd (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 8 Apr 2016 01:36:33 -0400
In-Reply-To: <56A1F1FC.5070402@peak-system.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Stephane Grosjean <s.grosjean@peak-system.com>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hello Stephane,

anything new to this FPGA topic?

Best regards,
Oliver

ps. I've seen that a ucan-based PCIe card was presented on CAN-CiA News=
letter.
Do you already have a plan for a mainline driver for it?
http://can-newsletter.org/hardware/host-interfaces/160331_fast-canfd-fo=
r-pci-express_peak/

On 01/22/2016 10:10 AM, Stephane Grosjean wrote:
> Hello Oliver,
>=20
> At the moment,  we think about how best to proceed.
> We've got one tool that is able to do the update, but we want to redu=
ce risks
> at their minimum.
>=20
> Keep intouch!
>=20
> Regards,
>=20
> St=C3=A9phane
>=20
> Le 21/01/2016 18:51, Oliver Hartkopp a =C3=A9crit :
>> Hi Stephane,
>>
>> On 01/20/2016 03:33 PM, Marc Kleine-Budde wrote:
>>> On 01/20/2016 03:29 PM, Stephane Grosjean wrote:
>>>> [ 2200.129168] peak_pci 0000:05:01.0: Warning: FW v1.2.0 needs a
>>>> workaround; update is available
>>> One per hardware device is enough.
>>> "Warning: FW v1.2.0 workaround active; Please update device Firmewa=
re."
>>>
>>> ...and a webpage displaying this message, so that you will find it.
>>> Maybe even add a link to the website in the commit message.
>>>
>> searching for a potential firmware update on the PEAK Website
>>
>>     http://www.peak-system.com/Firmware.180.0.html?&L=3D1
>>
>> I did not find anything about the PCIe Hardware.
>>
>> Will there be a Linux tool to apply the firmware update too?
>> I don't have any PCIe slots on Windows machines anymore 8-)
>>
>> Best regards,
>> Oliver
>>
>=20
> --=20
> PEAK-System Technik GmbH
> Sitz der Gesellschaft Darmstadt - HRB 9183 Geschaeftsfuehrung: A.Gach=
, U.Wilhelm
> --=20
