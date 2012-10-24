From: Andreas Larsson <andreas@gaisler.com>
Subject: Re: [PATCH v2] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Wed, 24 Oct 2012 15:31:43 +0200
Message-ID: <5087EDBF.2040108@gaisler.com>
References: <5076999F.6070302@pengutronix.de> <1350986241-8919-1-git-send-email-andreas@gaisler.com> <5086C543.2050404@grandegger.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from vsp-authed02.binero.net ([195.74.38.226]:17906 "HELO
	vsp-authed-03-02.binero.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S934459Ab2JXNby (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 24 Oct 2012 09:31:54 -0400
In-Reply-To: <5086C543.2050404@grandegger.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

On 10/23/2012 06:26 PM, Wolfgang Grandegger wrote:
> Hi,
>
> before I have a closer look I have some general questions, especially
> about the heavy usage of SysFS for configuring the IP core module.
> Generally, we are not allowed to use SysFS for CAN device configuration.
>
> - Why may the user want to configure the resources on a per device base?

The GRCAN core supports selecting between two different hardware interfaces. The 
parameters output0, output1 and selection configures these interfaces and 
selects which one to use. This can not be done in general. For output0 and 
output1 what value means what depends on what hardware is connected to the core. 
If a board has many GRCAN cores they might need different settings for these 
variables. In addition, switching between the two hardware interfaces is 
something that might be wanted to be done at runtime.

For the others module level configuration would work fine.


> - Aren't there good default values which work just fine for 99% of the
>   users?

For output0, output1 and selection, the answer is no due to the reasons pointed 
out above. For the bpr and buffer sizes, that is probably true.


> - Why could the resources not be configured via device tree (or platform
>   code)?
> - Are there other IP cores already supported by mainline Linux, e.g.
>   uart. How are they configured?

See further down on Documentation/devicetree/bindings/net/can/grcan.txt for 
discussion on the device tree matter, or do you something else than configuring 
via bsp files and the like?


>> +What:		/sys/class/net/<iface>/grcan/rxcode
>> +Date:		October 2012
>> +KernelVersion:	3.8
>> +Contact:	Andreas Larsson<andreas@gaisler.com>
>> +Description:
>> +		Configures the rxcode of the hardware filter. Received messages
>> +		for which ((message_id ^ rxcode) & rxmask) != 0 holds will be
>> +		filtered out in harware. Possible values in [0, 0x1fffffff].
>> +		The default value is set by the module parameter rxcode and can
>> +		be read at /sys/module/grcan/parameters/rxcode.
>> +
>> +What:		/sys/class/net/<iface>/grcan/rxmask
>> +Date:		October 2012
>> +KernelVersion:	3.8
>> +Contact:	Andreas Larsson<andreas@gaisler.com>
>> +Description:
>> +		Configures the rxmask of the hardware filter. Received messages
>> +		for which ((message_id ^ rxcode) & rxmask) != 0 holds will be
>> +		filtered out in harware. Possible values in [0, 0x1fffffff].
>> +		The default value is set by the module parameter rxmask and can
>> +		be read at /sys/module/grcan/parameters/rxmask.
>
> Hardware filters should definitely not be defined via SysFS. We do not
> have an interface yet, mainly because it does not fit into a multi user
> concept. Anyway, we need such an interface *sooner* than later. Needs
> some further thoughts.

OK, I'll get rid of that then and wait for such an interface in the future. It 
would be a pity if hardware filtering, that is a feature that would probably be 
used on an embedded system without multiple users, could never be realized 
because of the socket interface being a multi user concept. If root is the only 
one that can set it up it should be fine in my opinion. Nevertheless, I totally 
agree that a well defined API to enable it would be much nicer than going 
through SysFS.


>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/can/grcan.txt
>> @@ -0,0 +1,27 @@
>> +CAN controller for Aeroflex Gaisler GRCAN and GRHCAN.
>> +
>> +The GRCAN and CRHCAN CAN controllers are available in the GRLIB VHDL IP core
>> +library.
>> +
>> +Note: These properties are built from the AMBA plug&play in a Leon SPARC
>> +system (the ordinary environment for GRCAN and GRHCAN). There are no bsp
>> +files for sparc.
>> +
>> +Required properties:
>> +
>> +- name : Should be "GAISLER_GRCAN", "01_03d", "GAISLER_GRHCAN" or "01_034"
>
> A name should be "vendor,device", e.g. gaisler,grcan. It's also unusual
> to add release numbers. Also, you do not distinguish between the devices
> above. Then, just use one name and the others are compatible to that one
> (even if they are named differently). Well, I realized that the device
> tree police is less strict than it was 1..2 years ago... anyway, please
> have a look to the many examples around, also for CAN.

As I stated in the file, there are no bsp files for sparc. The device trees are 
generated by a boot loader or a prom. For a leon sparc system the boot loader 
gets information from the hardware, the AMBA plug&play, and generates the device 
trees accordingly.

As for 01_03d and 01_034, they are are the names, based on what is found in the 
plug&play, that are generated by a boot loader that does not have a mapping from 
the plug and play to a name. They are not release numbers. They are based on 
vendor and device numbers as found in the plug&play on a leon sparc system.

Compare with these drivers that all use these kind of names to match with the 
hardware:
- drivers/net/ethernet/aeroflex/greth.c
- drivers/tty/serial/apbuart.c
- drivers/usb/host/ehci-grlib.c
- drivers/usb/host/uhci-hcd.c
- drivers/video/grvga.c

The reason for adding Documentation/devicetree/bindings/net/can/grcan.txt in the 
first I guess is for someone that takes the IP core outside of a leon system and 
need to write a bsp file for the board. For a leon system (the ordinary 
environment for GRCAN and GRHCAN as pointed out in the file). nothing needs to 
be done for adding support for GRCAN for a new board. The bootloader takes care 
of that.


>> +- freq : Frequency of the external oscillator clock in Hz (the frequency of
>> +	the amba bus in the ordinary case)
>
> Ditto. "clock-frequency" is a common name for that purpose.

Once again, "freq" is the property name that is given by the boot loader. 
Compare with drivers/tty/serial/apbuart.c that also relies on "freq".


>> +
>> +- interrupts : Interrupt number for this device
>> +
>> +Optional properties:
>> +
>> +- systemid : If not present or if the value of the least significant 16 bits
>> +	of this 32-bit property is smaller than GRCAN_TXBUG_SAFE_GRLIB_VERSION
>> +	a bug workaround is activated.
>
> Why can't this be handled via compatible string?

This approach is used as the information is available from the boot loader in 
this form.


>> -	ima_appraise=	[IMA] appraise integrity measurements
>> -			Format: { "off" | "enforce" | "fix" }
>> -			default: "enforce"
>> -
>> -	ima_appraise_tcb [IMA]
>> -			The builtin appraise policy appraises all files
>> -			owned by uid=0.
>> -
> Hm, is this related? There are more below.

Oops, sorry. That is a mistake. I'll clean that up.


Thanks for the feedback!

Cheers,
Andreas Larsson
