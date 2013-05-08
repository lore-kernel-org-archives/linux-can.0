From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re:
Date: Wed, 08 May 2013 09:11:53 +0200
Message-ID: <5189FAB9.1040905@grandegger.com>
References: <CANdmM3MFEe-iXinRohUN9rEF-C2CoEg1va=nE7W-=KThogz7sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:42328 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188Ab3EHHL5 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 8 May 2013 03:11:57 -0400
In-Reply-To: <CANdmM3MFEe-iXinRohUN9rEF-C2CoEg1va=nE7W-=KThogz7sg@mail.gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: kedari appana <kedare06@gmail.com>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, Marc Kleine-Budde <mkl@pengutronix.de>

On 05/08/2013 08:25 AM, kedari appana wrote:
> Hi,
> 
>  if i type the below command i am getting the following errors
> # ip link show can0
> 2: can0: <NOARP40000> mtu 16 qdisc noop qlen 10
>     link/[280]

That's a strange output. Where does the "40000" come from? Maybe you are
using an old version of the "ip" program. The command shown below should
report:

  # ip link help
  ...
  TYPE := { vlan | veth | vcan | dummy | ifb | macvlan | can }

If you don't see "can", it's the wrong version.

> #cat /proc/interrupts
> in this i am not getting entry for my can interrupt handler

The device must be started to have the interrupt line requested. Please read

http://lxr.free-electrons.com/source/Documentation/networking/can.txt#L747

on how to use the "ip" program for CAN.

> #./canconfig can0 bitrate 50000 ctrlmode triple-sampling on
> this command was successfull but when i debugging it is showing  can0:
> bit-timing not yet defined
> 
> #If i use ifconfig can0 up
> error is can0: bit-timing not yet defined
> ifconfig: SIOCSIFFLAGS: Invalid argument
> Please help me what is the problem.

Your tools seem not to work properly. What does

 # canconfig can0

print out? Anyway, please try using "ip" in the first place.

Please do not repeat the same question multiple times. It does usually
not help in getting an answer more quickly.

Wolfgang.
