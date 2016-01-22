From: Stephane Grosjean <s.grosjean@peak-system.com>
Subject: Re: [PATCH] can/peak_pci: fix FPGA potential frame loss issue
Date: Fri, 22 Jan 2016 10:10:20 +0100
Message-ID: <56A1F1FC.5070402@peak-system.com>
References: <1453288532-15034-1-git-send-email-s.grosjean@peak-system.com>
 <569F9588.2090809@pengutronix.de> <569F99BE.70001@peak-system.com>
 <569F9AC5.6020706@pengutronix.de> <56A11AB2.5060200@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.peak-system.com ([213.157.13.214]:38644 "EHLO
	mail.peak-system.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbcAVJKh (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 22 Jan 2016 04:10:37 -0500
In-Reply-To: <56A11AB2.5060200@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: linux-can Mailing List <linux-can@vger.kernel.org>

Hello Oliver,

At the moment,  we think about how best to proceed.
We've got one tool that is able to do the update, but we want to reduce=
=20
risks at their minimum.

Keep intouch!

Regards,

St=C3=A9phane

Le 21/01/2016 18:51, Oliver Hartkopp a =C3=A9crit :
> Hi Stephane,
>
> On 01/20/2016 03:33 PM, Marc Kleine-Budde wrote:
>> On 01/20/2016 03:29 PM, Stephane Grosjean wrote:
>>> [ 2200.129168] peak_pci 0000:05:01.0: Warning: FW v1.2.0 needs a
>>> workaround; update is available
>> One per hardware device is enough.
>> "Warning: FW v1.2.0 workaround active; Please update device Firmewar=
e."
>>
>> ...and a webpage displaying this message, so that you will find it.
>> Maybe even add a link to the website in the commit message.
>>
> searching for a potential firmware update on the PEAK Website
>
> 	http://www.peak-system.com/Firmware.180.0.html?&L=3D1
>
> I did not find anything about the PCIe Hardware.
>
> Will there be a Linux tool to apply the firmware update too?
> I don't have any PCIe slots on Windows machines anymore 8-)
>
> Best regards,
> Oliver
>

--
PEAK-System Technik GmbH
Sitz der Gesellschaft Darmstadt - HRB 9183=20
Geschaeftsfuehrung: A.Gach, U.Wilhelm
--
