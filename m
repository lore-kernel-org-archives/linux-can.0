From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH v2] can: grcan: Add device driver for GRCAN and GRHCAN
 cores
Date: Tue, 23 Oct 2012 18:26:43 +0200
Message-ID: <5086C543.2050404@grandegger.com>
References: <5076999F.6070302@pengutronix.de> <1350986241-8919-1-git-send-email-andreas@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:50902 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757023Ab2JWQ0y (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 23 Oct 2012 12:26:54 -0400
In-Reply-To: <1350986241-8919-1-git-send-email-andreas@gaisler.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Andreas Larsson <andreas@gaisler.com>
Cc: linux-can@vger.kernel.org, mkl@pengutronix.de, devicetree-discuss@lists.ozlabs.org, software@gaisler.com

Hi,

before I have a closer look I have some general questions, especially
about the heavy usage of SysFS for configuring the IP core module.
Generally, we are not allowed to use SysFS for CAN device configuration.

- Why may the user want to configure the resources on a per device base?

- Aren't there good default values which work just fine for 99% of the
  users?

- Why could the resources not be configured via device tree (or platform
  code)?

- Are there other IP cores already supported by mainline Linux, e.g.
  uart. How are they configured?

On 10/23/2012 11:57 AM, Andreas Larsson wrote:
> This driver supports GRCAN and CRHCAN CAN controllers available in the GRLIB
> VHDL IP core library.
> 
> Signed-off-by: Andreas Larsson <andreas@gaisler.com>
> ---
>  Documentation/ABI/testing/sysfs-class-net-grcan    |  136 ++
>  .../devicetree/bindings/net/can/grcan.txt          |   27 +
>  Documentation/kernel-parameters.txt                |   88 +-
>  drivers/net/can/Kconfig                            |    9 +
>  drivers/net/can/Makefile                           |    1 +
>  drivers/net/can/grcan.c                            | 1735 ++++++++++++++++++++
>  6 files changed, 1952 insertions(+), 44 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-net-grcan
>  create mode 100644 Documentation/devicetree/bindings/net/can/grcan.txt
>  create mode 100644 drivers/net/can/grcan.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-net-grcan b/Documentation/ABI/testing/sysfs-class-net-grcan
> new file mode 100644
> index 0000000..c6eed07
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-net-grcan
> @@ -0,0 +1,136 @@
> +
> +What:		/sys/class/net/<iface>/grcan/enable0
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Hardware configuration of physical interface 0. This file reads
> +		and writes the "Enable 0" bit of the configuration register.
> +		Possible values: 0 or 1. See the GRCAN chapter of the GRLIB IP
> +		core library documentation for details.
> +		The default value is set by the module parameter enable0 and can
> +		be read at /sys/module/grcan/parameters/enable0.
> +
> +What:		/sys/class/net/<iface>/grcan/enable1
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Hardware configuration of physical interface 1. This file reads
> +		and writes the "Enable 1" bit of the configuration register.
> +		Possible values: 0 or 1. See the GRCAN chapter of the GRLIB IP
> +		core library documentation for details.
> +		The default value is set by the module parameter enable1 and can
> +		be read at /sys/module/grcan/parameters/enable1.
> +
> +What:		/sys/class/net/<iface>/grcan/selection
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Configuration of which physical interface to be used. Possible
> +		values: 0 or 1. See the GRCAN chapter of the GRLIB IP core
> +		library documentation for details.
> +		The default value is set by the module parameter selection and can
> +		be read at /sys/module/grcan/parameters/selection.
> +
> +What:		/sys/class/net/<iface>/grcan/bpr
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Configuration of the bpr baud rate scaler (not to be confused
> +		with the "brp" concept which in grcan is called scaler). From
> +		the socket can layer's point of view, divides the external clock
> +		frequency by 1 << value. Possible values in [0, 3].
> +		The default value is set by the module parameter bpr and can
> +		be read at /sys/module/grcan/parameters/bpr.
> +
> +What:		/sys/class/net/<iface>/grcan/txsize
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Configures the size of the tx buffer. Possible values: (value &
> +		0x1fffc0) == 0.
> +		The default value is set by the module parameter txsize and can
> +		be read at /sys/module/grcan/parameters/txsize.
> +
> +
> +What:		/sys/class/net/<iface>/grcan/rxsize
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Configures the size of the rx buffer. Possible values: (value &
> +		0x1fffc0) == 0.
> +		The default value is set by the module parameter rxsize and can
> +		be read at /sys/module/grcan/parameters/rxsize.
> +
> +
> +What:		/sys/class/net/<iface>/grcan/rxcode
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Configures the rxcode of the hardware filter. Received messages
> +		for which ((message_id ^ rxcode) & rxmask) != 0 holds will be
> +		filtered out in harware. Possible values in [0, 0x1fffffff].
> +		The default value is set by the module parameter rxcode and can
> +		be read at /sys/module/grcan/parameters/rxcode.
> +
> +What:		/sys/class/net/<iface>/grcan/rxmask
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Configures the rxmask of the hardware filter. Received messages
> +		for which ((message_id ^ rxcode) & rxmask) != 0 holds will be
> +		filtered out in harware. Possible values in [0, 0x1fffffff].
> +		The default value is set by the module parameter rxmask and can
> +		be read at /sys/module/grcan/parameters/rxmask.

Hardware filters should definitely not be defined via SysFS. We do not
have an interface yet, mainly because it does not fit into a multi user
concept. Anyway, we need such an interface *sooner* than later. Needs
some further thoughts.

> +
> +What:		/sys/class/net/<iface>/grcan/rxcode_basic
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Configures the rxcode of the hardware filter to match a basic
> +		id. Writable only. Result can be read in rxcode. Possible values
> +		in [0, 0x7ff].
> +
> +What:		/sys/class/net/<iface>/grcan/rxmask_basic
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Configures the rxmask of the hardware filter to match a basic
> +		id. Writable only. Result can be read in rxcode. Possible values
> +		in [0, 0x7ff].
> +
> +What:		/sys/class/net/<iface>/grcan/stat_ahberr_tx
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Statistics on number of AHB errors that has happened during tx
> +		(note that the device halts on AHB errors). Write anything to
> +		reset to 0.
> +
> +What:		/sys/class/net/<iface>/grcan/stat_ahberr_rx
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Statistics on number of AHB errors that has happened during rx
> +		(note that the device halts on AHB errors). Write anything to
> +		reset to 0.
> +
> +What:		/sys/class/net/<iface>/grcan/stat_hwfiltered
> +Date:		October 2012
> +KernelVersion:	3.8
> +Contact:	Andreas Larsson <andreas@gaisler.com>
> +Description:
> +		Statistics on number of hardware-filtered messages. Write anything to
> +		reset to 0.
> diff --git a/Documentation/devicetree/bindings/net/can/grcan.txt b/Documentation/devicetree/bindings/net/can/grcan.txt
> new file mode 100644
> index 0000000..a7180f1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/grcan.txt
> @@ -0,0 +1,27 @@
> +CAN controller for Aeroflex Gaisler GRCAN and GRHCAN.
> +
> +The GRCAN and CRHCAN CAN controllers are available in the GRLIB VHDL IP core
> +library.
> +
> +Note: These properties are built from the AMBA plug&play in a Leon SPARC
> +system (the ordinary environment for GRCAN and GRHCAN). There are no bsp
> +files for sparc.
> +
> +Required properties:
> +
> +- name : Should be "GAISLER_GRCAN", "01_03d", "GAISLER_GRHCAN" or "01_034"

A name should be "vendor,device", e.g. gaisler,grcan. It's also unusual
to add release numbers. Also, you do not distinguish between the devices
above. Then, just use one name and the others are compatible to that one
(even if they are named differently). Well, I realized that the device
tree police is less strict than it was 1..2 years ago... anyway, please
have a look to the many examples around, also for CAN.

> +- reg : Address and length of the register set for the device
> +
> +- freq : Frequency of the external oscillator clock in Hz (the frequency of
> +	the amba bus in the ordinary case)

Ditto. "clock-frequency" is a common name for that purpose.

> +
> +- interrupts : Interrupt number for this device
> +
> +Optional properties:
> +
> +- systemid : If not present or if the value of the least significant 16 bits
> +	of this 32-bit property is smaller than GRCAN_TXBUG_SAFE_GRLIB_VERSION
> +	a bug workaround is activated.

Why can't this be handled via compatible string?

> +
> +For further information look in the documentation for the GLIB IP core library.
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index 9776f06..32c924f 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -905,6 +905,46 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  	gpt		[EFI] Forces disk with valid GPT signature but
>  			invalid Protective MBR to be treated as GPT.
>  
> +	grcan.enable0=	[HW] The "Enable 0" bit of the configuration
> +			register. For more documentation, see
> +			Documentation/ABI/testing/sysfs-class-net-grcan
> +			Format: 0 | 1
> +			Default: 0
> +	grcan.enable1=	[HW] The "Enable 1" bit of the configuration
> +			register. For more documentation, see
> +			Documentation/ABI/testing/sysfs-class-net-grcan.
> +			Format: 0 | 1
> +			Default: 0
> +	grcan.selection=
> +			[HW] Selection of which physical interface to be
> +			used. For more documentation, see
> +			Documentation/ABI/testing/sysfs-class-net-grcan.
> +			Format: 0 | 1
> +			Default: 0
> +	grcan.bpr=	[HW] Configuration of the bpr baud rate scaler. For
> +			more documentation, see
> +			Documentation/ABI/testing/sysfs-class-net-grcan.
> +			Format: 0 | 1 | 2 | 3
> +			Default: 0
> +	grcan.txsize=	[HW] The size of the tx buffer. For more documentation,
> +			see Documentation/ABI/testing/sysfs-class-net-grcan.
> +			Format: <value> such that (value & 0x1fffc0) == 0.
> +			Default: 1024
> +	grcan.rxsize=	[HW] The size of the rx buffer. For more documentation,
> +			see Documentation/ABI/testing/sysfs-class-net-grcan.
> +			Format: <value> such that (value & 0x1fffc0) == 0.
> +			Default: 1024
> +	grcan.rxcode=	[HW] The rxcode of the hardware filter. For more
> +			documentation, see
> +			Documentation/ABI/testing/sysfs-class-net-grcan.
> +			Format: <value> in the range [0, 0x1fffffff]
> +			Default: 0
> +	grcan.rxmask=	[HW] The rxmask of the hardware filter. For more
> +			documentation, see
> +			Documentation/ABI/testing/sysfs-class-net-grcan.
> +			Format: <value> in the range [0, 0x1fffffff]
> +			Default: 0
> +
>  	hashdist=	[KNL,NUMA] Large hashes allocated during boot
>  			are distributed across NUMA nodes.  Defaults on
>  			for 64-bit NUMA, off otherwise.
> @@ -1051,14 +1091,6 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  	ihash_entries=	[KNL]
>  			Set number of hash buckets for inode cache.
>  
> -	ima_appraise=	[IMA] appraise integrity measurements
> -			Format: { "off" | "enforce" | "fix" }
> -			default: "enforce"
> -
> -	ima_appraise_tcb [IMA]
> -			The builtin appraise policy appraises all files
> -			owned by uid=0.
> -

Hm, is this related? There are more below.

I will have a closer look to the driver code later this week.

Thanks,

Wolfgang.

