From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Socketcan-users] CAN Data Transfer not happening at 1Mbps
Date: Fri, 03 Feb 2012 16:46:32 +0100
Message-ID: <4F2C0158.3060409@hartkopp.net>
References: <4ED62A07621E9C41B8CB2F608655EF45053759D1@POCITMSEXMB02.LntUniverse.com> <4F2AA2B4.2090906@grandegger.com> <4ED62A07621E9C41B8CB2F608655EF4505375D5A@POCITMSEXMB02.LntUniverse.com> <4F2B95B7.5070507@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:64922 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008Ab2BCPqc (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 3 Feb 2012 10:46:32 -0500
In-Reply-To: <4F2B95B7.5070507@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>, Nikhil Kamath <Nikhil.Kamath@lnties.com>
Cc: Linux-CAN <linux-can@vger.kernel.org>

On 03.02.2012 09:07, Wolfgang Grandegger wrote:

> On 02/03/2012 05:11 AM, Nikhil Kamath wrote:
>> Hi Wolfgang,
>> Below are the details you asked for:
>>
>> -This means you are not using a mainline kernel, right? Are you using Freescale's ltib linux-2.6.35 tree?
>> Yes , I am not using a mainline kernel , it's from the Freescale's LTIB tree.
>>
>>
>> - From what kernel version is the Flexcan driver derived?
>> I integrated the FlexCAN driver present in linux-2.6.38 mainline Kernel. I am not using the FlexCAN driver given by Freescale since it had issues , for e.g. I used to get the following error -RTNETLINK answers: Operation not supported.

(..)

>> Further , this is the log I got when I executed the following command -
>> root@freescale ~$ ip link set can0 up type can bitrate 1000000
>> flexcan flexcan.0: bitrate error 0.7%
> 
> That might make the trouble. The built-in algorithm to determine the
> bit-timing parameters does not work well for your clock frequency. Try
> to add "sjw=4" to the ip command.


Hi Wolfgang,

to set the sjw value with the ip tool is not implemented in
linux/drivers/net/can/dev.c in 2.6.38 nor in 2.6.35 ...

Maybe Nikhil can update all the stuff in linux/drivers/net/can from the
latest 3.2 kernel.

Alternatively the sjw setting support can be added to older versions by
applying this patch:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commitdiff;h=2e1143742789463c00ed5e7f9bf471f2b707b493

Regards,
Oliver
