From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [Socketcan-users] CAN Data Transfer not happening at 1Mbps
Date: Fri, 03 Feb 2012 20:27:14 +0100
Message-ID: <4F2C3512.8000006@grandegger.com>
References: <4ED62A07621E9C41B8CB2F608655EF45053759D1@POCITMSEXMB02.LntUniverse.com> <4F2AA2B4.2090906@grandegger.com> <4ED62A07621E9C41B8CB2F608655EF4505375D5A@POCITMSEXMB02.LntUniverse.com> <4F2B95B7.5070507@grandegger.com>,<4F2C0158.3060409@hartkopp.net> <4ED62A07621E9C41B8CB2F608655EF450537D6D7@POCITMSEXMB02.LntUniverse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:47200 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754743Ab2BCT1U (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 14:27:20 -0500
In-Reply-To: <4ED62A07621E9C41B8CB2F608655EF450537D6D7@POCITMSEXMB02.LntUniverse.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Nikhil Kamath <Nikhil.Kamath@lnties.com>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>, Linux-CAN <linux-can@vger.kernel.org>

On 02/03/2012 04:54 PM, Nikhil Kamath wrote:
> Thanks a lot. I will test by applying the patch .

For a quick try, you can also use (instead of "bitrate 1000000"):

  tq 90 prop-seg 3 phase-seg1 4 phase-seg2 3 sjw 4

Wolfgang.

> Regards,
> Nikhil
> ________________________________
> From: Oliver Hartkopp
> Sent: 03-02-2012 PM 09:19
> To: Wolfgang Grandegger; Nikhil Kamath
> Cc: Linux-CAN
> Subject: Re: [Socketcan-users] CAN Data Transfer not happening at 1Mbps
> 
> On 03.02.2012 09:07, Wolfgang Grandegger wrote:
> 
>> On 02/03/2012 05:11 AM, Nikhil Kamath wrote:
>>> Hi Wolfgang,
>>> Below are the details you asked for:
>>>
>>> -This means you are not using a mainline kernel, right? Are you using Freescale's ltib linux-2.6.35 tree?
>>> Yes , I am not using a mainline kernel , it's from the Freescale's LTIB tree.
>>>
>>>
>>> - From what kernel version is the Flexcan driver derived?
>>> I integrated the FlexCAN driver present in linux-2.6.38 mainline Kernel. I am not using the FlexCAN driver given by Freescale since it had issues , for e.g. I used to get the following error -RTNETLINK answers: Operation not supported.
> 
> (..)
> 
>>> Further , this is the log I got when I executed the following command -
>>> root@freescale ~$ ip link set can0 up type can bitrate 1000000
>>> flexcan flexcan.0: bitrate error 0.7%
>>
>> That might make the trouble. The built-in algorithm to determine the
>> bit-timing parameters does not work well for your clock frequency. Try
>> to add "sjw=4" to the ip command.
> 
> 
> Hi Wolfgang,
> 
> to set the sjw value with the ip tool is not implemented in
> linux/drivers/net/can/dev.c in 2.6.38 nor in 2.6.35 ...
> 
> Maybe Nikhil can update all the stuff in linux/drivers/net/can from the
> latest 3.2 kernel.
> 
> Alternatively the sjw setting support can be added to older versions by
> applying this patch:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=2e1143742789463c00ed5e7f9bf471f2b707b493
> 
> Regards,
> Oliver
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> Larsen & Toubro Limited
> 
> www.larsentoubro.com
> 
> This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.
> 

