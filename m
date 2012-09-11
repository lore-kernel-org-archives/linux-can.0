From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Antwort: Re: problem with adding socketcan isotp " frreescale
 imx"
Date: Tue, 11 Sep 2012 19:30:15 +0200
Message-ID: <504F7527.9080409@hartkopp.net>
References: <OF888EFFE9.4D2BD1DC-ONC1257A75.002CF71F-C1257A75.002DDB22@continental-corporation.com> <504E34E9.7020108@hartkopp.net> <OF00E617F7.E1525EED-ONC1257A76.0033FAFA-C1257A76.00346CF5@continental-corporation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.160]:33600 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751706Ab2IKRaS (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Sep 2012 13:30:18 -0400
In-Reply-To: <OF00E617F7.E1525EED-ONC1257A76.0033FAFA-C1257A76.00346CF5@continental-corporation.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Mahesh.Maharjan-EXT@continental-corporation.com
Cc: linux-can@vger.kernel.org

On 11.09.2012 11:32, Mahesh.Maharjan-EXT@continental-corporation.com wrote:

> Thanks Oliver for reply.
> 
> As far , I do not see  can-isotp 
> 
> But when I tried with modprobe.. the module do not exist in system...
>  But it compile comletely


Hm - i don't know the kernel build and installation process of your BSP.
Maybe not all modules are copied with your installation process.

When there is a can-isotp.ko please try to load it manually:

- go to the build directory cd (...)/net/can
- insmod ./can-isotp.ko

Regards,
Oliver


> On 10.09.2012 10:20, Mahesh.Maharjan-EXT@continental-corporation.com 
> wrote:
> 
>>  I am trying to use SocketCAN  ISOTP in freescale imx board. I added 
> isotp 
>> source file in freescale BSP (linux 2,638 imx ). It compile properly , 
> but 
>> when I trying use in application it is not supported. As socket and 
>> binding with isotp is not with  working with it.
> 
> 
> Did you see some can-isotp banner in dmesg?
> Have you tried 'modprobe can-isotp'?
> Does it appear in lsmod?
> 


