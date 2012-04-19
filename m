From: Martin Kozusky <mkozusky@kkmicro.cz>
Subject: Re: CAN messages being lost on i.MX25 with flexcan
Date: Thu, 19 Apr 2012 13:21:00 +0200
Message-ID: <jmoses$rmu$1@dough.gmane.org>
References: <jmonvu$nu8$1@dough.gmane.org> <4F8FEF02.7040503@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:44883 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752828Ab2DSLVP (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Thu, 19 Apr 2012 07:21:15 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1SKpQI-00012I-FS
	for linux-can@vger.kernel.org; Thu, 19 Apr 2012 13:21:14 +0200
Received: from 213.191.105.242 ([213.191.105.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 19 Apr 2012 13:21:14 +0200
Received: from mkozusky by 213.191.105.242 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Thu, 19 Apr 2012 13:21:14 +0200
In-Reply-To: <4F8FEF02.7040503@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Dne 19.4.2012 12:54, Wolfgang Grandegger napsal(a):
> On 04/19/2012 12:04 PM, Martin Kozusky wrote:
>> Hello,
>> I'm using Voipac i.MX25 module with flexcan, kernel 2.6.38.9.
>> I'm sending the data at 250kbps, around 1100 msgs/sec. When I enable the
>> canbus interface (canconfig can0 start), CPU load is higher, that is
>> understandable, there are many interrupts. I'm not doing anything else
>> then using recvmsg (or recvmmsg which is little better), but some
>> messages are still lost (around 1500 messages lost from 467 000 being
>> send from another source). When I start doing something (like  "cat
>> /proc/interrupts",  or write to file), many more messages are lost.
>>
>> Do you have any idea how to fix this? I need to make some CAN messages
>> logger and I cannot lose any message (idealy :) So I made big buffer in
>> my program so that I don't need to write the messages into the file
>> while "recording" is enabled, after "recording" is switched off, I write
>> the buffer into the file, but that is still not good enough.
>> Is there any way how to write to some buffer directly in flexcan driver
>> (the best would be in the IRQ routine) and then read messages from this
>> buffer in my program?
>> Or are just interrupts lost when doing something else in the system and
>> I cannot fix this? Or can I somehow specify that "can rx interrupts" has
>> highest prioroty?
>
> Do you already know where the packets are dropped (get lost). Maybe your
> user space app is simply not faster enough to process them in time. You
> can check that with the candump option "-d".

Hello Wolfgang,
I don't know where it gets lost. But I'm just making select() and 
recvmmsg in my app now.
Now when I'm trying candump -d, it shows messages and between that:

   can0  18FFC33D  [8] 4A E6 00 00 03 00 00 F6
   can0  1CEFB8F3  [8] 34 42 23 3D 8C 01 00 00
DROPCOUNT: dropped 245 CAN frames on 'can0' socket (total drops 30886)
   can0  18FF0AEF  [8] 70 76 46 7C A7 9E 2A 6A
   can0  18FF0AF0  [8] B0 7E FB 7D A7 DC 27 69
   can0  18FEBF0B  [8] F5 03 79 81 69 74 6E 79

I've sent around 40 000 messages.
Does this help somehow to identify where the problem is?
I found out that if I (in my program) don't printf every frame, then 
dropcount is better, so I think when candump would only show dropps and 
not every frame then it would also get better.

This is my /proc/interrupts

root@vmx25 /opt$ cat /proc/interrupts
            CPU0
   0:          0           -  spi_imx
   5:      32827           -  IMX-uart
   9:        129           -  sdhci
  13:          0           -  spi_imx
  25:          5           -  imxdi_rtc
  33:      12168           -  mxc_nand
  34:          1           -  mxc-sdma
  37:     109275           -  ehci_hcd:usb1
  43:    1624971           -  can0
  46:          0           -  mxcadc
  54:     195357           -  i.MX Timer Tick
164:          0           -  ESDHCI card 0 detect
Err:          0


I have another problem - when I send messages and nobody is acking them 
(no other device on CANbus), system stops responding until I put another 
device onto CANbus, but I think I should start new thread with this.

Martin


> Wolfgang.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


