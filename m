From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Tue, 30 Oct 2012 10:29:00 +0100
Message-ID: <508F9DDC.50003@grandegger.com>
References: <5076999F.6070302@pengutronix.de> <1350986241-8919-1-git-send-email-andreas@gaisler.com> <5086C543.2050404@grandegger.com> <5087EDBF.2040108@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:38474 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754860Ab2J3J30 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 30 Oct 2012 05:29:26 -0400
In-Reply-To: <5087EDBF.2040108@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

Hi Andreas,

sorry for late answer. Other duties are keeping me busy. Your v3
triggered a closer look...

On 10/24/2012 03:31 PM, Andreas Larsson wrote:
> On 10/23/2012 06:26 PM, Wolfgang Grandegger wrote:
>> Hi,
>>
>> before I have a closer look I have some general questions, especially
>> about the heavy usage of SysFS for configuring the IP core module.
>> Generally, we are not allowed to use SysFS for CAN device configuration.
>>
>> - Why may the user want to configure the resources on a per device base?
> 
> The GRCAN core supports selecting between two different hardware
> interfaces. The parameters output0, output1 and selection configures
> these interfaces and selects which one to use. This can not be done in
> general. For output0 and output1 what value means what depends on what
> hardware is connected to the core. If a board has many GRCAN cores they
> might need different settings for these variables. In addition,
> switching between the two hardware interfaces is something that might be
> wanted to be done at runtime.
> 
> For the others module level configuration would work fine.

OK.

>
>> - Aren't there good default values which work just fine for 99% of the
>>   users?
>
> For output0, output1 and selection, the answer is no due to the reasons
> pointed out above. For the bpr and buffer sizes, that is probably
true.

OK, reducing the number of SysFS files to a really useful number (for
end users) would be nice.

...

>>> +What:        /sys/class/net/<iface>/grcan/rxmask
>>> +Date:        October 2012
>>> +KernelVersion:    3.8
>>> +Contact:    Andreas Larsson<andreas@gaisler.com>
>>> +Description:
>>> +        Configures the rxmask of the hardware filter. Received messages
>>> +        for which ((message_id ^ rxcode) & rxmask) != 0 holds will be
>>> +        filtered out in harware. Possible values in [0, 0x1fffffff].
>>> +        The default value is set by the module parameter rxmask and can
>>> +        be read at /sys/module/grcan/parameters/rxmask.
>>
>> Hardware filters should definitely not be defined via SysFS. We do not
>> have an interface yet, mainly because it does not fit into a multi user
>> concept. Anyway, we need such an interface *sooner* than later. Needs
>> some further thoughts.
> 
> OK, I'll get rid of that then and wait for such an interface in the
> future. It would be a pity if hardware filtering, that is a feature that
> would probably be used on an embedded system without multiple users,
> could never be realized because of the socket interface being a multi
> user concept. If root is the only one that can set it up it should be
> fine in my opinion. Nevertheless, I totally agree that a well defined
> API to enable it would be much nicer than going through SysFS.

Yes, we definitely need a generic interface to support hardware filters.
I put it on top of my Linux-CAN-TODO-List.


>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/can/grcan.txt
>>> @@ -0,0 +1,27 @@
>>> +CAN controller for Aeroflex Gaisler GRCAN and GRHCAN.
>>> +
>>> +The GRCAN and CRHCAN CAN controllers are available in the GRLIB VHDL
>>> IP core
>>> +library.
>>> +
>>> +Note: These properties are built from the AMBA plug&play in a Leon
>>> SPARC
>>> +system (the ordinary environment for GRCAN and GRHCAN). There are no
>>> bsp
>>> +files for sparc.
>>> +
>>> +Required properties:
>>> +
>>> +- name : Should be "GAISLER_GRCAN", "01_03d", "GAISLER_GRHCAN" or
>>> "01_034"
>>
>> A name should be "vendor,device", e.g. gaisler,grcan. It's also unusual
>> to add release numbers. Also, you do not distinguish between the devices
>> above. Then, just use one name and the others are compatible to that one
>> (even if they are named differently). Well, I realized that the device
>> tree police is less strict than it was 1..2 years ago... anyway, please
>> have a look to the many examples around, also for CAN.
> 
> As I stated in the file, there are no bsp files for sparc. The device
> trees are generated by a boot loader or a prom. For a leon sparc system
> the boot loader gets information from the hardware, the AMBA plug&play,
> and generates the device trees accordingly.

Ah, the system uses good old classic OpenFirmware. Sorry, I missed that.
This makes a lot of my questions obsolete.



