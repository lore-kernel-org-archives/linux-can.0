From: Lucas Zampar Bernardi <lucas.zampar@gmail.com>
Subject: Re: MCP2515 DTS support
Date: Wed, 26 Feb 2014 10:12:04 -0300
Message-ID: <530DE824.2060803@gmail.com>
References: <144554558e0.2748.cbaa067694a7e68fb76a213b35423fb5@gmail.com> <5308FE97.8090804@gmail.com> <530D0C96.6060207@pengutronix.de> <1393388253.686159171@f330.i.mail.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030308070308080908040809"
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yh0-f49.google.com ([209.85.213.49]:36209 "EHLO
	mail-yh0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322AbaBZNMP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 26 Feb 2014 08:12:15 -0500
Received: by mail-yh0-f49.google.com with SMTP id f10so259847yha.22
        for <linux-can@vger.kernel.org>; Wed, 26 Feb 2014 05:12:15 -0800 (PST)
In-Reply-To: <1393388253.686159171@f330.i.mail.ru>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Alexander Shiyan <shc_work@mail.ru>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

This is a multi-part message in MIME format.
--------------030308070308080908040809
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Alexander,


Follow attach my DTS file and my dmesg log.
How you can see, we have "mcp251x: probe of spi32766.2 failed with error 
-2.".
I discovered that the cause is the clock config structure, because if 
I've forced a frequency hardcode all driver works.
The point where I've forced is:

on mcp251x.c

static int mcp251x_can_probe(struct spi_device *spi)
{
     const struct of_device_id *of_id = of_match_device(mcp251x_of_match,
                                &spi->dev);
     struct mcp251x_platform_data *pdata = dev_get_platdata(&spi->dev);
     struct net_device *net;
     struct mcp251x_priv *priv;
     int freq, ret = -ENODEV;
     struct clk *clk;

     clk = devm_clk_get(&spi->dev, NULL);
     if (IS_ERR(clk)) {
         if (pdata)
             freq = pdata->oscillator_frequency;
         else
             freq = 20 * 1000 * 1000;  /* crystal freq HARDCODE */
            // return PTR_ERR(clk);
     } else {
         freq = clk_get_rate(clk);
     }
....


I'm really don't know if it's a dts config problem or a driver problem.




regards,


Lucas




On 26-02-2014 01:17, Alexander Shiyan wrote:
> Вторник, 25 февраля 2014, 22:35 +01:00 от Marc Kleine-Budde <mkl@pengutronix.de>:
>> On 02/22/2014 08:46 PM, Lucas Zampar Bernardi wrote:
>>> Hi again,
>>>
>>> I found the causes of problem, and now I need to know if I was setting
>>> wrong structure or there are driver problem.
>>> I've had this modification on mcp251x.c:
>>>
>>> static int mcp251x_can_probe(struct spi_device *spi)
>>> {
>>>      const struct of_device_id *of_id = of_match_device(mcp251x_of_match,
>>>                                 &spi->dev);
>>>      struct mcp251x_platform_data *pdata = dev_get_platdata(&spi->dev);
>>>      struct net_device *net;
>>>      struct mcp251x_priv *priv;
>>>      int freq, ret = -ENODEV;
>>>      struct clk *clk;
>>>
>>>
>>>      clk = devm_clk_get(&spi->dev, NULL);
>>>      dev_dbg(&spi->dev, "MCP2515: clk = devm_clk_get(&spi->dev, NULL)");
>>>      if (IS_ERR(clk)) {
>>>          if (pdata)
>>>          {
>>>              freq = pdata->oscillator_frequency;
>>>          }
>>>          else
>>>          {
>>>>>         freq = 20 * 1000 * 1000;    // FORCE FREQUENCY to 20Mhz
>>>              //return PTR_ERR(clk);
>>>          }
>>>      } else {
>>>          dev_dbg(&spi->dev, "MCP2515: freq = clk_get_rate(clk);");
>>>          freq = clk_get_rate(clk);
>>>      }
>>>
>>>
>>> Then the driver start to run.
>>>
>>> I think that the problem is about how to set a correct clock.
>>>
>>>
>>> I put on can node:
>>>                  can0: can@1 {
>>>                      compatible = "microchip,mcp2515";
>>>                      reg = <2>;
> can0 ... can@1 ... reg = <2>...
> Uhhh....
>
> Unfortunately I do not see the original message, please repeat it to me.
> Boot log is also required, as long as I do not understand what the problem
> you have there.
>
> ---


--------------030308070308080908040809
Content-Type: text/x-log;
 name="dmesg.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.log"

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.14.0-rc4+ (zampar@zampar-dell) (gcc version 4.7.3 (Buildroot 2014.02-rc2-00081-g5ec4f42) ) #3 Wed Feb 26 09:43:30 BRT 2014
[    0.000000] CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=00053177
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine model: MyMachine
[    0.000000] Memory policy: Data cache writeback
[    0.000000] AT91: Detected soc type: at91sam9x5
[    0.000000] AT91: Detected soc subtype: at91sam9g25
[    0.000000] AT91: sram at 0x300000 of 0x8000 mapped at 0xfef70000
[    0.000000] On node 0 totalpages: 32768
[    0.000000] free_area_init_node: node 0, pgdat c04d81a4, node_mem_map c7efa000
[    0.000000]   Normal zone: 256 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 32768 pages, LIFO batch:7
[    0.000000] Clocks: CPU 400 MHz, master 133 MHz, main 12.000 MHz
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 32512
[    0.000000] Kernel command line: console=ttyS0,115200 earlyprintk root=/dev/nfs rw nfsroot=10.185.5.4:/work/nfs ip=10.185.5.102
[    0.000000] PID hash table entries: 512 (order: -1, 2048 bytes)
[    0.000000] Dentry cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Inode-cache hash table entries: 8192 (order: 3, 32768 bytes)
[    0.000000] Memory: 124660K/131072K available (3548K kernel code, 170K rwdata, 1068K rodata, 138K init, 217K bss, 6412K reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
[    0.000000]     vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
[    0.000000]     modules : 0xbf000000 - 0xc0000000   (  16 MB)
[    0.000000]       .text : 0xc0008000 - 0xc048a430   (4618 kB)
[    0.000000]       .init : 0xc048b000 - 0xc04ad84c   ( 139 kB)
[    0.000000]       .data : 0xc04ae000 - 0xc04d8900   ( 171 kB)
[    0.000000]        .bss : 0xc04d8900 - 0xc050ef94   ( 218 kB)
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] sched_clock: 32 bits at 128 Hz, resolution 7812500ns, wraps every 16777216000000000ns
[    0.000000] Console: colour dummy device 80x30
[    0.054687] Calibrating delay loop... 198.76 BogoMIPS (lpj=775168)
[    0.054687] pid_max: default: 32768 minimum: 301
[    0.062500] Mount-cache hash table entries: 512
[    0.070312] CPU: Testing write buffer coherency: ok
[    0.070312] Setting up static identity map for 0x2035c910 - 0x2035c968
[    0.070312] devtmpfs: initialized
[    0.070312] device: 'platform': device_add
[    0.070312] PM: Adding info for No Bus:platform
[    0.070312] bus: 'platform': registered
[    0.070312] bus: 'cpu': registered
[    0.070312] device: 'cpu': device_add
[    0.078125] PM: Adding info for No Bus:cpu
[    0.078125] bus: 'container': registered
[    0.078125] device: 'container': device_add
[    0.078125] PM: Adding info for No Bus:container
[    0.078125] bus: 'workqueue': registered
[    0.078125] device: 'workqueue': device_add
[    0.078125] PM: Adding info for No Bus:workqueue
[    0.078125] pinctrl core: initialized pinctrl subsystem
[    0.078125] NET: Registered protocol family 16
[    0.078125] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.078125] device class 'bdi': registering
[    0.078125] device class 'gpio': registering
[    0.078125] device class 'tty': registering
[    0.078125] device class 'vtconsole': registering
[    0.078125] device: 'vtcon0': device_add
[    0.078125] PM: Adding info for No Bus:vtcon0
[    0.085937] bus: 'spi': registered
[    0.085937] device class 'spi_master': registering
[    0.085937] bus: 'i2c': registered
[    0.085937] bus: 'i2c': add driver dummy
[    0.085937] device: 'ahb.0': device_add
[    0.085937] bus: 'platform': add device ahb.0
[    0.085937] PM: Adding info for platform:ahb.0
[    0.085937] device: 'apb.1': device_add
[    0.085937] bus: 'platform': add device apb.1
[    0.085937] PM: Adding info for platform:apb.1
[    0.085937] device: 'fffff000.interrupt-controller': device_add
[    0.085937] bus: 'platform': add device fffff000.interrupt-controller
[    0.085937] PM: Adding info for platform:fffff000.interrupt-controller
[    0.085937] device: 'ffffe800.ramc': device_add
[    0.085937] bus: 'platform': add device ffffe800.ramc
[    0.085937] PM: Adding info for platform:ffffe800.ramc
[    0.085937] device: 'fffffc00.pmc': device_add
[    0.085937] bus: 'platform': add device fffffc00.pmc
[    0.085937] PM: Adding info for platform:fffffc00.pmc
[    0.085937] device: 'fffffe00.rstc': device_add
[    0.085937] bus: 'platform': add device fffffe00.rstc
[    0.085937] PM: Adding info for platform:fffffe00.rstc
[    0.085937] device: 'fffffe10.shdwc': device_add
[    0.085937] bus: 'platform': add device fffffe10.shdwc
[    0.085937] PM: Adding info for platform:fffffe10.shdwc
[    0.085937] device: 'fffffe30.timer': device_add
[    0.085937] bus: 'platform': add device fffffe30.timer
[    0.085937] PM: Adding info for platform:fffffe30.timer
[    0.093750] device: 'f8008000.timer': device_add
[    0.093750] bus: 'platform': add device f8008000.timer
[    0.093750] PM: Adding info for platform:f8008000.timer
[    0.093750] device: 'f800c000.timer': device_add
[    0.093750] bus: 'platform': add device f800c000.timer
[    0.093750] PM: Adding info for platform:f800c000.timer
[    0.093750] device: 'ffffec00.dma-controller': device_add
[    0.093750] bus: 'platform': add device ffffec00.dma-controller
[    0.093750] PM: Adding info for platform:ffffec00.dma-controller
[    0.093750] device: 'ffffee00.dma-controller': device_add
[    0.093750] bus: 'platform': add device ffffee00.dma-controller
[    0.093750] PM: Adding info for platform:ffffee00.dma-controller
[    0.093750] device: 'pinctrl.2': device_add
[    0.093750] bus: 'platform': add device pinctrl.2
[    0.093750] PM: Adding info for platform:pinctrl.2
[    0.093750] device: 'fffff400.gpio': device_add
[    0.093750] bus: 'platform': add device fffff400.gpio
[    0.093750] PM: Adding info for platform:fffff400.gpio
[    0.093750] device: 'fffff600.gpio': device_add
[    0.093750] bus: 'platform': add device fffff600.gpio
[    0.093750] PM: Adding info for platform:fffff600.gpio
[    0.093750] device: 'fffff800.gpio': device_add
[    0.093750] bus: 'platform': add device fffff800.gpio
[    0.093750] PM: Adding info for platform:fffff800.gpio
[    0.101562] device: 'fffffa00.gpio': device_add
[    0.101562] bus: 'platform': add device fffffa00.gpio
[    0.101562] PM: Adding info for platform:fffffa00.gpio
[    0.101562] device: 'f0008000.mmc': device_add
[    0.101562] bus: 'platform': add device f0008000.mmc
[    0.101562] PM: Adding info for platform:f0008000.mmc
[    0.101562] device: 'fffff200.serial': device_add
[    0.101562] bus: 'platform': add device fffff200.serial
[    0.101562] PM: Adding info for platform:fffff200.serial
[    0.101562] device: 'f8010000.i2c': device_add
[    0.101562] bus: 'platform': add device f8010000.i2c
[    0.101562] PM: Adding info for platform:f8010000.i2c
[    0.101562] device: 'f8014000.i2c': device_add
[    0.101562] bus: 'platform': add device f8014000.i2c
[    0.101562] PM: Adding info for platform:f8014000.i2c
[    0.101562] device: 'f804c000.adc': device_add
[    0.101562] bus: 'platform': add device f804c000.adc
[    0.101562] PM: Adding info for platform:f804c000.adc
[    0.101562] device: 'f0000000.spi': device_add
[    0.101562] bus: 'platform': add device f0000000.spi
[    0.101562] PM: Adding info for platform:f0000000.spi
[    0.101562] device: 'fffffeb0.rtc': device_add
[    0.101562] bus: 'platform': add device fffffeb0.rtc
[    0.101562] PM: Adding info for platform:fffffeb0.rtc
[    0.101562] device: 'f802c000.ethernet': device_add
[    0.101562] bus: 'platform': add device f802c000.ethernet
[    0.109375] PM: Adding info for platform:f802c000.ethernet
[    0.109375] device: '40000000.nand': device_add
[    0.109375] bus: 'platform': add device 40000000.nand
[    0.109375] PM: Adding info for platform:40000000.nand
[    0.109375] device: '600000.ohci': device_add
[    0.109375] bus: 'platform': add device 600000.ohci
[    0.109375] PM: Adding info for platform:600000.ohci
[    0.109375] device: '700000.ehci': device_add
[    0.109375] bus: 'platform': add device 700000.ehci
[    0.109375] PM: Adding info for platform:700000.ehci
[    0.109375] device: 'leds.3': device_add
[    0.109375] bus: 'platform': add device leds.3
[    0.109375] PM: Adding info for platform:leds.3
[    0.109375] device: 'gpio_keys.4': device_add
[    0.109375] bus: 'platform': add device gpio_keys.4
[    0.109375] PM: Adding info for platform:gpio_keys.4
[    0.109375] device: 'onewire.5': device_add
[    0.109375] bus: 'platform': add device onewire.5
[    0.109375] PM: Adding info for platform:onewire.5
[    0.109375] No ATAGs?
[    0.109375] AT91: Power Management
[    0.109375] Registering platform device 'cpuidle-at91.0'. Parent at platform
[    0.109375] device: 'cpuidle-at91.0': device_add
[    0.109375] bus: 'platform': add device cpuidle-at91.0
[    0.109375] PM: Adding info for platform:cpuidle-at91.0
[    0.109375] AT91: Starting after power-restored wakeup
[    0.109375] bus: 'platform': add driver gpio-at91
[    0.109375] bus: 'platform': driver_probe_device: matched device fffff400.gpio with driver gpio-at91
[    0.109375] bus: 'platform': really_probe: probing driver gpio-at91 with device fffff400.gpio
[    0.109375] gpio-at91 fffff400.gpio: no default pinctrl state
[    0.109375] device: 'gpiochip0': device_add
[    0.109375] PM: Adding info for No Bus:gpiochip0
[    0.109375] gpio-at91 fffff400.gpio: at address fefff400
[    0.117187] driver: 'fffff400.gpio': driver_bound: bound to device 'gpio-at91'
[    0.117187] bus: 'platform': really_probe: bound device fffff400.gpio to driver gpio-at91
[    0.117187] bus: 'platform': driver_probe_device: matched device fffff600.gpio with driver gpio-at91
[    0.117187] bus: 'platform': really_probe: probing driver gpio-at91 with device fffff600.gpio
[    0.117187] gpio-at91 fffff600.gpio: no default pinctrl state
[    0.117187] device: 'gpiochip32': device_add
[    0.117187] PM: Adding info for No Bus:gpiochip32
[    0.117187] gpio-at91 fffff600.gpio: at address fefff600
[    0.117187] driver: 'fffff600.gpio': driver_bound: bound to device 'gpio-at91'
[    0.117187] bus: 'platform': really_probe: bound device fffff600.gpio to driver gpio-at91
[    0.117187] bus: 'platform': driver_probe_device: matched device fffff800.gpio with driver gpio-at91
[    0.117187] bus: 'platform': really_probe: probing driver gpio-at91 with device fffff800.gpio
[    0.117187] gpio-at91 fffff800.gpio: no default pinctrl state
[    0.117187] device: 'gpiochip64': device_add
[    0.117187] PM: Adding info for No Bus:gpiochip64
[    0.117187] gpio-at91 fffff800.gpio: at address fefff800
[    0.117187] driver: 'fffff800.gpio': driver_bound: bound to device 'gpio-at91'
[    0.117187] bus: 'platform': really_probe: bound device fffff800.gpio to driver gpio-at91
[    0.117187] bus: 'platform': driver_probe_device: matched device fffffa00.gpio with driver gpio-at91
[    0.117187] bus: 'platform': really_probe: probing driver gpio-at91 with device fffffa00.gpio
[    0.117187] gpio-at91 fffffa00.gpio: no default pinctrl state
[    0.117187] device: 'gpiochip96': device_add
[    0.117187] PM: Adding info for No Bus:gpiochip96
[    0.117187] gpio-at91 fffffa00.gpio: at address fefffa00
[    0.117187] driver: 'fffffa00.gpio': driver_bound: bound to device 'gpio-at91'
[    0.117187] bus: 'platform': really_probe: bound device fffffa00.gpio to driver gpio-at91
[    0.117187] bus: 'platform': add driver pinctrl-at91
[    0.117187] bus: 'platform': driver_probe_device: matched device pinctrl.2 with driver pinctrl-at91
[    0.117187] bus: 'platform': really_probe: probing driver pinctrl-at91 with device pinctrl.2
[    0.117187] pinctrl-at91 pinctrl.2: no default pinctrl state
[    0.117187] pinctrl-at91 pinctrl.2: initialized AT91 pinctrl driver
[    0.117187] driver: 'pinctrl.2': driver_bound: bound to device 'pinctrl-at91'
[    0.117187] bus: 'platform': really_probe: bound device pinctrl.2 to driver pinctrl-at91
[    0.117187] device class 'dma': registering
[    0.117187] bus: 'platform': add driver atmel_tcb
[    0.125000] bus: 'platform': driver_probe_device: matched device f8008000.timer with driver atmel_tcb
[    0.125000] bus: 'platform': really_probe: probing driver atmel_tcb with device f8008000.timer
[    0.125000] atmel_tcb f8008000.timer: no default pinctrl state
[    0.125000] driver: 'f8008000.timer': driver_bound: bound to device 'atmel_tcb'
[    0.125000] bus: 'platform': really_probe: bound device f8008000.timer to driver atmel_tcb
[    0.125000] bus: 'platform': driver_probe_device: matched device f800c000.timer with driver atmel_tcb
[    0.125000] bus: 'platform': really_probe: probing driver atmel_tcb with device f800c000.timer
[    0.125000] atmel_tcb f800c000.timer: no default pinctrl state
[    0.125000] driver: 'f800c000.timer': driver_bound: bound to device 'atmel_tcb'
[    0.125000] bus: 'platform': really_probe: bound device f800c000.timer to driver atmel_tcb
[    0.125000] tcb_clksrc: tc0 at 16.166 MHz
[    0.125000] device: 'cpu0': device_add
[    0.125000] bus: 'cpu': add device cpu0
[    0.125000] PM: Adding info for cpu:cpu0
[    0.179687] device: 'writeback': device_add
[    0.179687] bus: 'workqueue': add device writeback
[    0.179687] PM: Adding info for workqueue:writeback
[    0.179687] device: 'default': device_add
[    0.179687] PM: Adding info for No Bus:default
[    0.179687] bio: create slab <bio-0> at 0
[    0.179687] device class 'block': registering
[    0.179687] bus: 'platform': add driver at_hdmac
[    0.179687] bus: 'platform': driver_probe_device: matched device ffffec00.dma-controller with driver at_hdmac
[    0.179687] bus: 'platform': really_probe: probing driver at_hdmac with device ffffec00.dma-controller
[    0.179687] at_hdmac ffffec00.dma-controller: no default pinctrl state
[    0.179687] at_hdmac ffffec00.dma-controller: Atmel AHB DMA Controller ( cpy slave ), 8 channels
[    0.179687] device: 'dma0chan0': device_add
[    0.179687] PM: Adding info for No Bus:dma0chan0
[    0.179687] device: 'dma0chan1': device_add
[    0.179687] PM: Adding info for No Bus:dma0chan1
[    0.179687] device: 'dma0chan2': device_add
[    0.179687] PM: Adding info for No Bus:dma0chan2
[    0.179687] device: 'dma0chan3': device_add
[    0.179687] PM: Adding info for No Bus:dma0chan3
[    0.179687] device: 'dma0chan4': device_add
[    0.179687] PM: Adding info for No Bus:dma0chan4
[    0.187500] device: 'dma0chan5': device_add
[    0.187500] PM: Adding info for No Bus:dma0chan5
[    0.187500] device: 'dma0chan6': device_add
[    0.187500] PM: Adding info for No Bus:dma0chan6
[    0.187500] device: 'dma0chan7': device_add
[    0.187500] PM: Adding info for No Bus:dma0chan7
[    0.187500] driver: 'ffffec00.dma-controller': driver_bound: bound to device 'at_hdmac'
[    0.187500] bus: 'platform': really_probe: bound device ffffec00.dma-controller to driver at_hdmac
[    0.187500] bus: 'platform': driver_probe_device: matched device ffffee00.dma-controller with driver at_hdmac
[    0.187500] bus: 'platform': really_probe: probing driver at_hdmac with device ffffee00.dma-controller
[    0.187500] at_hdmac ffffee00.dma-controller: no default pinctrl state
[    0.187500] at_hdmac ffffee00.dma-controller: Atmel AHB DMA Controller ( cpy slave ), 8 channels
[    0.187500] device: 'dma1chan0': device_add
[    0.187500] PM: Adding info for No Bus:dma1chan0
[    0.187500] device: 'dma1chan1': device_add
[    0.187500] PM: Adding info for No Bus:dma1chan1
[    0.187500] device: 'dma1chan2': device_add
[    0.187500] PM: Adding info for No Bus:dma1chan2
[    0.187500] device: 'dma1chan3': device_add
[    0.187500] PM: Adding info for No Bus:dma1chan3
[    0.187500] device: 'dma1chan4': device_add
[    0.187500] PM: Adding info for No Bus:dma1chan4
[    0.187500] device: 'dma1chan5': device_add
[    0.187500] PM: Adding info for No Bus:dma1chan5
[    0.187500] device: 'dma1chan6': device_add
[    0.187500] PM: Adding info for No Bus:dma1chan6
[    0.195312] device: 'dma1chan7': device_add
[    0.195312] PM: Adding info for No Bus:dma1chan7
[    0.195312] driver: 'ffffee00.dma-controller': driver_bound: bound to device 'at_hdmac'
[    0.195312] bus: 'platform': really_probe: bound device ffffee00.dma-controller to driver at_hdmac
[    0.195312] device class 'misc': registering
[    0.195312] device class 'scsi_host': registering
[    0.195312] bus: 'scsi': registered
[    0.195312] device class 'scsi_device': registering
[    0.195312] SCSI subsystem initialized
[    0.195312] device class 'mdio_bus': registering
[    0.195312] bus: 'mdio_bus': registered
[    0.195312] bus: 'mdio_bus': add driver Generic PHY
[    0.195312] bus: 'mdio_bus': add driver Generic 10G PHY
[    0.203125] bus: 'usb': registered
[    0.203125] bus: 'usb': add driver usbfs
[    0.203125] usbcore: registered new interface driver usbfs
[    0.203125] bus: 'usb': add driver hub
[    0.203125] usbcore: registered new interface driver hub
[    0.203125] bus: 'usb': add driver usb
[    0.203125] usbcore: registered new device driver usb
[    0.203125] device class 'input': registering
[    0.203125] device class 'rtc': registering
[    0.203125] bus: 'platform': add driver at91_i2c
[    0.203125] bus: 'platform': driver_probe_device: matched device f8010000.i2c with driver at91_i2c
[    0.203125] bus: 'platform': really_probe: probing driver at91_i2c with device f8010000.i2c
[    0.203125] at91_i2c f8010000.i2c: no sleep pinctrl state
[    0.203125] at91_i2c f8010000.i2c: no idle pinctrl state
[    0.203125] at91_i2c f8010000.i2c: using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
[    0.203125] device: 'i2c-0': device_add
[    0.203125] bus: 'i2c': add device i2c-0
[    0.203125] PM: Adding info for i2c:i2c-0
[    0.203125] device: '0-0050': device_add
[    0.203125] bus: 'i2c': add device 0-0050
[    0.203125] PM: Adding info for i2c:0-0050
[    0.203125] at91_i2c f8010000.i2c: AT91 i2c bus driver.
[    0.203125] driver: 'f8010000.i2c': driver_bound: bound to device 'at91_i2c'
[    0.203125] bus: 'platform': really_probe: bound device f8010000.i2c to driver at91_i2c
[    0.203125] bus: 'platform': driver_probe_device: matched device f8014000.i2c with driver at91_i2c
[    0.203125] bus: 'platform': really_probe: probing driver at91_i2c with device f8014000.i2c
[    0.203125] at91_i2c f8014000.i2c: no sleep pinctrl state
[    0.203125] at91_i2c f8014000.i2c: no idle pinctrl state
[    0.210937] at91_i2c f8014000.i2c: using dma1chan0 (tx) and dma1chan1 (rx) for DMA transfers
[    0.210937] device: 'i2c-1': device_add
[    0.210937] bus: 'i2c': add device i2c-1
[    0.210937] PM: Adding info for i2c:i2c-1
[    0.210937] at91_i2c f8014000.i2c: AT91 i2c bus driver.
[    0.210937] driver: 'f8014000.i2c': driver_bound: bound to device 'at91_i2c'
[    0.210937] bus: 'platform': really_probe: bound device f8014000.i2c to driver at91_i2c
[    0.210937] device class 'watchdog': registering
[    0.210937] bus: 'mmc': registered
[    0.210937] device class 'mmc_host': registering
[    0.210937] bus: 'sdio': registered
[    0.210937] device class 'leds': registering
[    0.210937] device class 'net': registering
[    0.210937] device: 'lo': device_add
[    0.210937] PM: Adding info for No Bus:lo
[    0.218750] Switched to clocksource tcb_clksrc
[    0.218750] device class 'mem': registering
[    0.218750] device: 'mem': device_add
[    0.218750] PM: Adding info for No Bus:mem
[    0.218750] device: 'kmem': device_add
[    0.218750] PM: Adding info for No Bus:kmem
[    0.218750] device: 'null': device_add
[    0.218750] PM: Adding info for No Bus:null
[    0.218750] device: 'zero': device_add
[    0.218750] PM: Adding info for No Bus:zero
[    0.218750] device: 'full': device_add
[    0.218750] PM: Adding info for No Bus:full
[    0.218750] device: 'random': device_add
[    0.218750] PM: Adding info for No Bus:random
[    0.218750] device: 'urandom': device_add
[    0.218750] PM: Adding info for No Bus:urandom
[    0.218750] device: 'kmsg': device_add
[    0.218750] PM: Adding info for No Bus:kmsg
[    0.226562] device: 'tty': device_add
[    0.226562] PM: Adding info for No Bus:tty
[    0.226562] device: 'console': device_add
[    0.226562] PM: Adding info for No Bus:console
[    0.226562] device: 'tty0': device_add
[    0.226562] PM: Adding info for No Bus:tty0
[    0.226562] device class 'vc': registering
[    0.226562] device: 'vcs': device_add
[    0.226562] PM: Adding info for No Bus:vcs
[    0.226562] device: 'vcsa': device_add
[    0.226562] PM: Adding info for No Bus:vcsa
[    0.226562] device: 'vcs1': device_add
[    0.226562] PM: Adding info for No Bus:vcs1
[    0.226562] device: 'vcsa1': device_add
[    0.226562] PM: Adding info for No Bus:vcsa1
[    0.226562] device: 'tty1': device_add
[    0.226562] PM: Adding info for No Bus:tty1
[    0.226562] device: 'tty2': device_add
[    0.234375] PM: Adding info for No Bus:tty2
[    0.234375] device: 'tty3': device_add
[    0.234375] PM: Adding info for No Bus:tty3
[    0.234375] device: 'tty4': device_add
[    0.234375] PM: Adding info for No Bus:tty4
[    0.234375] device: 'tty5': device_add
[    0.234375] PM: Adding info for No Bus:tty5
[    0.234375] device: 'tty6': device_add
[    0.234375] PM: Adding info for No Bus:tty6
[    0.234375] device: 'tty7': device_add
[    0.234375] PM: Adding info for No Bus:tty7
[    0.234375] device: 'tty8': device_add
[    0.234375] PM: Adding info for No Bus:tty8
[    0.234375] device: 'tty9': device_add
[    0.234375] PM: Adding info for No Bus:tty9
[    0.234375] device: 'tty10': device_add
[    0.234375] PM: Adding info for No Bus:tty10
[    0.234375] device: 'tty11': device_add
[    0.242187] PM: Adding info for No Bus:tty11
[    0.242187] device: 'tty12': device_add
[    0.242187] PM: Adding info for No Bus:tty12
[    0.242187] device: 'tty13': device_add
[    0.242187] PM: Adding info for No Bus:tty13
[    0.242187] device: 'tty14': device_add
[    0.242187] PM: Adding info for No Bus:tty14
[    0.242187] device: 'tty15': device_add
[    0.242187] PM: Adding info for No Bus:tty15
[    0.242187] device: 'tty16': device_add
[    0.242187] PM: Adding info for No Bus:tty16
[    0.242187] device: 'tty17': device_add
[    0.242187] PM: Adding info for No Bus:tty17
[    0.242187] device: 'tty18': device_add
[    0.242187] PM: Adding info for No Bus:tty18
[    0.242187] device: 'tty19': device_add
[    0.242187] PM: Adding info for No Bus:tty19
[    0.242187] device: 'tty20': device_add
[    0.250000] PM: Adding info for No Bus:tty20
[    0.250000] device: 'tty21': device_add
[    0.250000] PM: Adding info for No Bus:tty21
[    0.250000] device: 'tty22': device_add
[    0.250000] PM: Adding info for No Bus:tty22
[    0.250000] device: 'tty23': device_add
[    0.250000] PM: Adding info for No Bus:tty23
[    0.250000] device: 'tty24': device_add
[    0.250000] PM: Adding info for No Bus:tty24
[    0.250000] device: 'tty25': device_add
[    0.250000] PM: Adding info for No Bus:tty25
[    0.250000] device: 'tty26': device_add
[    0.250000] PM: Adding info for No Bus:tty26
[    0.250000] device: 'tty27': device_add
[    0.250000] PM: Adding info for No Bus:tty27
[    0.250000] device: 'tty28': device_add
[    0.250000] PM: Adding info for No Bus:tty28
[    0.250000] device: 'tty29': device_add
[    0.257812] PM: Adding info for No Bus:tty29
[    0.257812] device: 'tty30': device_add
[    0.257812] PM: Adding info for No Bus:tty30
[    0.257812] device: 'tty31': device_add
[    0.257812] PM: Adding info for No Bus:tty31
[    0.257812] device: 'tty32': device_add
[    0.257812] PM: Adding info for No Bus:tty32
[    0.257812] device: 'tty33': device_add
[    0.257812] PM: Adding info for No Bus:tty33
[    0.257812] device: 'tty34': device_add
[    0.257812] PM: Adding info for No Bus:tty34
[    0.257812] device: 'tty35': device_add
[    0.257812] PM: Adding info for No Bus:tty35
[    0.257812] device: 'tty36': device_add
[    0.257812] PM: Adding info for No Bus:tty36
[    0.257812] device: 'tty37': device_add
[    0.257812] PM: Adding info for No Bus:tty37
[    0.257812] device: 'tty38': device_add
[    0.265625] PM: Adding info for No Bus:tty38
[    0.265625] device: 'tty39': device_add
[    0.265625] PM: Adding info for No Bus:tty39
[    0.265625] device: 'tty40': device_add
[    0.265625] PM: Adding info for No Bus:tty40
[    0.265625] device: 'tty41': device_add
[    0.265625] PM: Adding info for No Bus:tty41
[    0.265625] device: 'tty42': device_add
[    0.265625] PM: Adding info for No Bus:tty42
[    0.265625] device: 'tty43': device_add
[    0.265625] PM: Adding info for No Bus:tty43
[    0.265625] device: 'tty44': device_add
[    0.265625] PM: Adding info for No Bus:tty44
[    0.265625] device: 'tty45': device_add
[    0.265625] PM: Adding info for No Bus:tty45
[    0.265625] device: 'tty46': device_add
[    0.265625] PM: Adding info for No Bus:tty46
[    0.265625] device: 'tty47': device_add
[    0.273437] PM: Adding info for No Bus:tty47
[    0.273437] device: 'tty48': device_add
[    0.273437] PM: Adding info for No Bus:tty48
[    0.273437] device: 'tty49': device_add
[    0.273437] PM: Adding info for No Bus:tty49
[    0.273437] device: 'tty50': device_add
[    0.273437] PM: Adding info for No Bus:tty50
[    0.273437] device: 'tty51': device_add
[    0.273437] PM: Adding info for No Bus:tty51
[    0.273437] device: 'tty52': device_add
[    0.273437] PM: Adding info for No Bus:tty52
[    0.273437] device: 'tty53': device_add
[    0.273437] PM: Adding info for No Bus:tty53
[    0.273437] device: 'tty54': device_add
[    0.273437] PM: Adding info for No Bus:tty54
[    0.273437] device: 'tty55': device_add
[    0.273437] PM: Adding info for No Bus:tty55
[    0.273437] device: 'tty56': device_add
[    0.281250] PM: Adding info for No Bus:tty56
[    0.281250] device: 'tty57': device_add
[    0.281250] PM: Adding info for No Bus:tty57
[    0.281250] device: 'tty58': device_add
[    0.281250] PM: Adding info for No Bus:tty58
[    0.281250] device: 'tty59': device_add
[    0.281250] PM: Adding info for No Bus:tty59
[    0.281250] device: 'tty60': device_add
[    0.281250] PM: Adding info for No Bus:tty60
[    0.281250] device: 'tty61': device_add
[    0.281250] PM: Adding info for No Bus:tty61
[    0.281250] device: 'tty62': device_add
[    0.281250] PM: Adding info for No Bus:tty62
[    0.281250] device: 'tty63': device_add
[    0.281250] PM: Adding info for No Bus:tty63
[    0.281250] device class 'firmware': registering
[    0.289062] NET: Registered protocol family 2
[    0.289062] TCP established hash table entries: 1024 (order: 0, 4096 bytes)
[    0.289062] TCP bind hash table entries: 1024 (order: 0, 4096 bytes)
[    0.289062] TCP: Hash tables configured (established 1024 bind 1024)
[    0.289062] TCP: reno registered
[    0.289062] UDP hash table entries: 256 (order: 0, 4096 bytes)
[    0.289062] UDP-Lite hash table entries: 256 (order: 0, 4096 bytes)
[    0.289062] NET: Registered protocol family 1
[    0.289062] RPC: Registered named UNIX socket transport module.
[    0.289062] RPC: Registered udp transport module.
[    0.289062] RPC: Registered tcp transport module.
[    0.289062] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.289062] bus: 'clocksource': registered
[    0.289062] device: 'clocksource': device_add
[    0.289062] PM: Adding info for No Bus:clocksource
[    0.289062] device: 'clocksource0': device_add
[    0.289062] bus: 'clocksource': add device clocksource0
[    0.289062] PM: Adding info for clocksource:clocksource0
[    0.289062] bus: 'platform': add driver alarmtimer
[    0.289062] Registering platform device 'alarmtimer'. Parent at platform
[    0.289062] device: 'alarmtimer': device_add
[    0.289062] bus: 'platform': add device alarmtimer
[    0.289062] PM: Adding info for platform:alarmtimer
[    0.289062] bus: 'platform': driver_probe_device: matched device alarmtimer with driver alarmtimer
[    0.289062] bus: 'platform': really_probe: probing driver alarmtimer with device alarmtimer
[    0.289062] alarmtimer alarmtimer: no default pinctrl state
[    0.289062] driver: 'alarmtimer': driver_bound: bound to device 'alarmtimer'
[    0.289062] bus: 'platform': really_probe: bound device alarmtimer to driver alarmtimer
[    0.296875] bus: 'clockevents': registered
[    0.296875] device: 'clockevents': device_add
[    0.296875] PM: Adding info for No Bus:clockevents
[    0.296875] device: 'clockevent0': device_add
[    0.296875] bus: 'clockevents': add device clockevent0
[    0.296875] PM: Adding info for clockevents:clockevent0
[    0.296875] futex hash table entries: 256 (order: -1, 2048 bytes)
[    0.296875] NTFS driver 2.1.30 [Flags: R/W].
[    0.296875] msgmni has been set to 243
[    0.296875] io scheduler noop registered (default)
[    0.296875] device: 'ptyp0': device_add
[    0.296875] PM: Adding info for No Bus:ptyp0
[    0.296875] device: 'ptyp1': device_add
[    0.296875] PM: Adding info for No Bus:ptyp1
[    0.304687] device: 'ptyp2': device_add
[    0.304687] PM: Adding info for No Bus:ptyp2
[    0.304687] device: 'ptyp3': device_add
[    0.304687] PM: Adding info for No Bus:ptyp3
[    0.304687] device: 'ttyp0': device_add
[    0.304687] PM: Adding info for No Bus:ttyp0
[    0.304687] device: 'ttyp1': device_add
[    0.304687] PM: Adding info for No Bus:ttyp1
[    0.304687] device: 'ttyp2': device_add
[    0.304687] PM: Adding info for No Bus:ttyp2
[    0.304687] device: 'ttyp3': device_add
[    0.304687] PM: Adding info for No Bus:ttyp3
[    0.304687] device: 'ptmx': device_add
[    0.304687] PM: Adding info for No Bus:ptmx
[    0.304687] bus: 'platform': add driver atmel_usart
[    0.304687] bus: 'platform': driver_probe_device: matched device fffff200.serial with driver atmel_usart
[    0.304687] bus: 'platform': really_probe: probing driver atmel_usart with device fffff200.serial
[    0.304687] atmel_usart fffff200.serial: no sleep pinctrl state
[    0.304687] atmel_usart fffff200.serial: no idle pinctrl state
[    0.304687] fffff200.serial: ttyS0 at MMIO 0xfffff200 (irq = 16, base_baud = 8333333) is a ATMEL_SERIAL
[    0.648437] console [ttyS0] enabled
[    0.656250] device: 'ttyS0': device_add
[    0.656250] PM: Adding info for No Bus:ttyS0
[    0.656250] driver: 'fffff200.serial': driver_bound: bound to device 'atmel_usart'
[    0.656250] bus: 'platform': really_probe: bound device fffff200.serial to driver atmel_usart
[    0.656250] bus: 'platform': add driver atmel-trng
[    0.656250] device: '1:0': device_add
[    0.656250] PM: Adding info for No Bus:1:0
[    0.656250] device: 'ram0': device_add
[    0.656250] PM: Adding info for No Bus:ram0
[    0.656250] device: '1:1': device_add
[    0.656250] PM: Adding info for No Bus:1:1
[    0.656250] device: 'ram1': device_add
[    0.656250] PM: Adding info for No Bus:ram1
[    0.664062] device: '1:2': device_add
[    0.664062] PM: Adding info for No Bus:1:2
[    0.664062] device: 'ram2': device_add
[    0.664062] PM: Adding info for No Bus:ram2
[    0.664062] device: '1:3': device_add
[    0.664062] PM: Adding info for No Bus:1:3
[    0.664062] device: 'ram3': device_add
[    0.664062] PM: Adding info for No Bus:ram3
[    0.664062] brd: module loaded
[    0.671875] device: 'loop-control': device_add
[    0.671875] PM: Adding info for No Bus:loop-control
[    0.671875] device: '7:0': device_add
[    0.671875] PM: Adding info for No Bus:7:0
[    0.671875] device: 'loop0': device_add
[    0.671875] PM: Adding info for No Bus:loop0
[    0.671875] device: '7:1': device_add
[    0.671875] PM: Adding info for No Bus:7:1
[    0.671875] device: 'loop1': device_add
[    0.671875] PM: Adding info for No Bus:loop1
[    0.671875] device: '7:2': device_add
[    0.671875] PM: Adding info for No Bus:7:2
[    0.671875] device: 'loop2': device_add
[    0.679687] PM: Adding info for No Bus:loop2
[    0.679687] device: '7:3': device_add
[    0.679687] PM: Adding info for No Bus:7:3
[    0.679687] device: 'loop3': device_add
[    0.679687] PM: Adding info for No Bus:loop3
[    0.679687] device: '7:4': device_add
[    0.679687] PM: Adding info for No Bus:7:4
[    0.679687] device: 'loop4': device_add
[    0.679687] PM: Adding info for No Bus:loop4
[    0.679687] device: '7:5': device_add
[    0.679687] PM: Adding info for No Bus:7:5
[    0.679687] device: 'loop5': device_add
[    0.679687] PM: Adding info for No Bus:loop5
[    0.687500] device: '7:6': device_add
[    0.687500] PM: Adding info for No Bus:7:6
[    0.687500] device: 'loop6': device_add
[    0.687500] PM: Adding info for No Bus:loop6
[    0.687500] device: '7:7': device_add
[    0.687500] PM: Adding info for No Bus:7:7
[    0.687500] device: 'loop7': device_add
[    0.687500] PM: Adding info for No Bus:loop7
[    0.687500] loop: module loaded
[    0.695312] bus: 'platform': add driver atmel_pwm
[    0.695312] bus: 'platform': remove driver atmel_pwm
[    0.695312] driver: 'atmel_pwm': driver_release
[    0.695312] bus: 'i2c': add driver at24
[    0.695312] bus: 'i2c': driver_probe_device: matched device 0-0050 with driver at24
[    0.695312] bus: 'i2c': really_probe: probing driver at24 with device 0-0050
[    0.695312] at24 0-0050: no default pinctrl state
[    0.695312] at24 0-0050: 65536 byte 24c512 EEPROM, writable, 128 bytes/write
[    0.703125] driver: '0-0050': driver_bound: bound to device 'at24'
[    0.703125] bus: 'i2c': really_probe: bound device 0-0050 to driver at24
[    0.703125] device class 'scsi_disk': registering
[    0.703125] bus: 'scsi': add driver sd
[    0.703125] device class 'mtd': registering
[    0.703125] device: 'mtd-unmap': device_add
[    0.703125] PM: Adding info for No Bus:mtd-unmap
[    0.703125] device: 'mtd-romap': device_add
[    0.703125] PM: Adding info for No Bus:mtd-romap
[    0.703125] device: 'mtd-rwmap': device_add
[    0.703125] PM: Adding info for No Bus:mtd-rwmap
[    0.703125] bus: 'spi': add driver mtd_dataflash
[    0.703125] bus: 'platform': add driver atmel_nand
[    0.703125] bus: 'platform': driver_probe_device: matched device 40000000.nand with driver atmel_nand
[    0.703125] bus: 'platform': really_probe: probing driver atmel_nand with device 40000000.nand
[    0.703125] atmel_nand 40000000.nand: no sleep pinctrl state
[    0.703125] atmel_nand 40000000.nand: no idle pinctrl state
[    0.703125] bus: 'platform': add driver atmel_nand_nfc
[    0.718750] atmel_nand 40000000.nand: Use On Flash BBT
[    0.718750] atmel_nand 40000000.nand: No DMA support for NAND access.
[    0.726562] nand: device found, Manufacturer ID: 0xec, Chip ID: 0xda
[    0.734375] nand: Samsung NAND 256MiB 3,3V 8-bit
[    0.742187] nand: 256MiB, SLC, page size: 2048, OOB size: 64
[    0.742187] atmel_nand 40000000.nand: can't detect min. ECC, assume 2 bits in 512 bytes
[    0.750000] atmel_nand 40000000.nand: Initialize PMECC params, cap: 2, sector: 512
[    0.757812] Bad block table found at page 131008, version 0x01
[    0.765625] Bad block table found at page 130944, version 0x01
[    0.773437] nand_read_bbt: bad block at 0x0000057a0000
[    0.781250] nand_read_bbt: bad block at 0x000006e20000
[    0.781250] nand_read_bbt: bad block at 0x000008800000
[    0.789062] nand_read_bbt: bad block at 0x000008fa0000
[    0.789062] nand_read_bbt: bad block at 0x00000d460000
[    0.796875] nand_read_bbt: bad block at 0x00000e7c0000
[    0.804687] 5 ofpart partitions found on MTD device atmel_nand
[    0.812500] Creating 5 MTD partitions on "atmel_nand":
[    0.812500] 0x000000000000-0x000000040000 : "at91bootstrap"
[    0.820312] device: 'mtd0': device_add
[    0.820312] PM: Adding info for No Bus:mtd0
[    0.820312] device: 'mtd0ro': device_add
[    0.820312] PM: Adding info for No Bus:mtd0ro
[    0.820312] device: '31:0': device_add
[    0.820312] PM: Adding info for No Bus:31:0
[    0.820312] device: 'mtdblock0': device_add
[    0.820312] PM: Adding info for No Bus:mtdblock0
[    0.828125] 0x000000040000-0x0000000c0000 : "u-boot"
[    0.828125] device: 'mtd1': device_add
[    0.828125] PM: Adding info for No Bus:mtd1
[    0.828125] device: 'mtd1ro': device_add
[    0.828125] PM: Adding info for No Bus:mtd1ro
[    0.828125] device: '31:1': device_add
[    0.828125] PM: Adding info for No Bus:31:1
[    0.835937] device: 'mtdblock1': device_add
[    0.835937] PM: Adding info for No Bus:mtdblock1
[    0.835937] 0x0000000c0000-0x000000200000 : "U-Boot Env"
[    0.835937] device: 'mtd2': device_add
[    0.835937] PM: Adding info for No Bus:mtd2
[    0.843750] device: 'mtd2ro': device_add
[    0.843750] PM: Adding info for No Bus:mtd2ro
[    0.843750] device: '31:2': device_add
[    0.843750] PM: Adding info for No Bus:31:2
[    0.843750] device: 'mtdblock2': device_add
[    0.843750] PM: Adding info for No Bus:mtdblock2
[    0.843750] 0x000000200000-0x000000800000 : "kernel"
[    0.851562] device: 'mtd3': device_add
[    0.851562] PM: Adding info for No Bus:mtd3
[    0.851562] device: 'mtd3ro': device_add
[    0.851562] PM: Adding info for No Bus:mtd3ro
[    0.851562] device: '31:3': device_add
[    0.851562] PM: Adding info for No Bus:31:3
[    0.851562] device: 'mtdblock3': device_add
[    0.851562] PM: Adding info for No Bus:mtdblock3
[    0.851562] 0x000000800000-0x000020000000 : "rootfs"
[    0.859375] mtd: partition "rootfs" extends beyond the end of device "atmel_nand" -- size truncated to 0xf800000
[    0.867187] device: 'mtd4': device_add
[    0.867187] PM: Adding info for No Bus:mtd4
[    0.867187] device: 'mtd4ro': device_add
[    0.867187] PM: Adding info for No Bus:mtd4ro
[    0.875000] device: '31:4': device_add
[    0.875000] PM: Adding info for No Bus:31:4
[    0.875000] device: 'mtdblock4': device_add
[    0.875000] PM: Adding info for No Bus:mtdblock4
[    0.875000] driver: '40000000.nand': driver_bound: bound to device 'atmel_nand'
[    0.875000] bus: 'platform': really_probe: bound device 40000000.nand to driver atmel_nand
[    0.875000] device class 'spidev': registering
[    0.875000] bus: 'spi': add driver spidev
[    0.875000] bus: 'platform': add driver atmel_spi
[    0.875000] bus: 'platform': driver_probe_device: matched device f0000000.spi with driver atmel_spi
[    0.875000] bus: 'platform': really_probe: probing driver atmel_spi with device f0000000.spi
[    0.875000] atmel_spi f0000000.spi: no sleep pinctrl state
[    0.875000] atmel_spi f0000000.spi: no idle pinctrl state
[    0.875000] atmel_spi f0000000.spi: version: 0x212
[    0.882812] atmel_spi f0000000.spi: Using dma0chan2 (tx) and dma0chan3 (rx) for DMA transfers
[    0.890625] atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 (irq 26)
[    0.898437] device: 'spi32766': device_add
[    0.898437] PM: Adding info for No Bus:spi32766
[    0.898437] atmel_spi f0000000.spi: registered master spi32766 (dynamic)
[    0.898437] spi spi32766.0: setup: bpw 8 mode 0x0 -> csr0 00000002
[    0.898437] spi spi32766.0: setup mode 0, 8 bits/w, 10000000 Hz max --> 0
[    0.898437] device: 'spi32766.0': device_add
[    0.898437] bus: 'spi': add device spi32766.0
[    0.898437] PM: Adding info for spi:spi32766.0
[    0.898437] bus: 'spi': driver_probe_device: matched device spi32766.0 with driver mtd_dataflash
[    0.898437] bus: 'spi': really_probe: probing driver mtd_dataflash with device spi32766.0
[    0.898437] mtd_dataflash spi32766.0: no default pinctrl state
[    0.898437] mtd_dataflash spi32766.0: new message c783fc58 submitted for spi32766.0
[    0.898437] mtd_dataflash spi32766.0: activate 14, mr 000e0031
[    0.898437] atmel_spi f0000000.spi:   start pio xfer c783fc88: len 1 tx c78697a0 rx   (null) bitpw 8
[    0.898437] atmel_spi f0000000.spi:   start pio xfer c783fcac: len 3 tx   (null) rx c78697a1 bitpw 8
[    0.898437] atmel_spi f0000000.spi:   start pio xfer c783fcac: len 3 tx   (null) rx c78697a1 bitpw 8
[    0.898437] atmel_spi f0000000.spi:   start pio xfer c783fcac: len 3 tx   (null) rx c78697a1 bitpw 8
[    0.898437] mtd_dataflash spi32766.0:   xfer c783fc88: len 1 tx c78697a0/00000000 rx   (null)/00000000
[    0.898437] mtd_dataflash spi32766.0:   xfer c783fcac: len 3 tx   (null)/00000000 rx c78697a1/00000000
[    0.898437] mtd_dataflash spi32766.0: DEactivate 14, mr 000f0031
[    0.898437] mtd_dataflash spi32766.0: new message c783fc58 submitted for spi32766.0
[    0.898437] mtd_dataflash spi32766.0: activate 14, mr 000e0031
[    0.898437] atmel_spi f0000000.spi:   start pio xfer c783fc88: len 1 tx c78697a0 rx   (null) bitpw 8
[    0.898437] atmel_spi f0000000.spi:   start pio xfer c783fcac: len 1 tx   (null) rx c78697a1 bitpw 8
[    0.898437] mtd_dataflash spi32766.0:   xfer c783fc88: len 1 tx c78697a0/00000000 rx   (null)/00000000
[    0.898437] mtd_dataflash spi32766.0:   xfer c783fcac: len 1 tx   (null)/00000000 rx c78697a1/00000000
[    0.898437] mtd_dataflash spi32766.0: DEactivate 14, mr 000f0031
[    0.898437] mtd_dataflash spi32766.0: AT45DB321x (4224 KBytes) pagesize 528 bytes, OTP
[    0.906250] device: 'mtd5': device_add
[    0.906250] PM: Adding info for No Bus:mtd5
[    0.914062] device: 'mtd5ro': device_add
[    0.914062] PM: Adding info for No Bus:mtd5ro
[    0.914062] device: '31:5': device_add
[    0.914062] PM: Adding info for No Bus:31:5
[    0.914062] device: 'mtdblock5': device_add
[    0.914062] PM: Adding info for No Bus:mtdblock5
[    0.914062] driver: 'spi32766.0': driver_bound: bound to device 'mtd_dataflash'
[    0.914062] bus: 'spi': really_probe: bound device spi32766.0 to driver mtd_dataflash
[    0.914062] atmel_spi f0000000.spi: registered child spi32766.0
[    0.914062] spi spi32766.2: setup: bpw 8 mode 0x0 -> csr2 00000002
[    0.914062] spi spi32766.2: setup mode 0, 8 bits/w, 10000000 Hz max --> 0
[    0.914062] device: 'spi32766.2': device_add
[    0.914062] bus: 'spi': add device spi32766.2
[    0.914062] PM: Adding info for spi:spi32766.2
[    0.914062] atmel_spi f0000000.spi: registered child spi32766.2
[    0.914062] driver: 'f0000000.spi': driver_bound: bound to device 'atmel_spi'
[    0.914062] bus: 'platform': really_probe: bound device f0000000.spi to driver atmel_spi
[    0.914062] bus: 'mdio_bus': add driver Davicom DM9161E
[    0.914062] bus: 'mdio_bus': add driver Davicom DM9161A
[    0.921875] bus: 'mdio_bus': add driver Davicom DM9131
[    0.921875] bus: 'mdio_bus': add driver SMSC LAN83C185
[    0.921875] bus: 'mdio_bus': add driver SMSC LAN8187
[    0.921875] bus: 'mdio_bus': add driver SMSC LAN8700
[    0.921875] bus: 'mdio_bus': add driver SMSC LAN911x Internal PHY
[    0.921875] bus: 'mdio_bus': add driver SMSC LAN8710/LAN8720
[    0.921875] bus: 'mdio_bus': add driver Micrel KS8737
[    0.921875] bus: 'mdio_bus': add driver Micrel KSZ8021 or KSZ8031
[    0.921875] bus: 'mdio_bus': add driver Micrel KSZ8031
[    0.921875] bus: 'mdio_bus': add driver Micrel KSZ8041
[    0.921875] bus: 'mdio_bus': add driver Micrel KSZ8041RNLI
[    0.921875] bus: 'mdio_bus': add driver Micrel KSZ8051
[    0.921875] bus: 'mdio_bus': add driver Micrel KSZ8001 or KS8721
[    0.921875] bus: 'mdio_bus': add driver Micrel KSZ8081 or KSZ8091
[    0.929687] bus: 'mdio_bus': add driver Micrel KSZ8061
[    0.929687] bus: 'mdio_bus': add driver Micrel KSZ9021 Gigabit PHY
[    0.929687] bus: 'mdio_bus': add driver Micrel KSZ9031 Gigabit PHY
[    0.929687] bus: 'mdio_bus': add driver Micrel KSZ8873MLL Switch
[    0.929687] bus: 'mdio_bus': add driver Micrel KSZ886X Switch
[    0.929687] vcan: Virtual CAN interface driver
[    0.937500] CAN device driver interface
[    0.937500] bus: 'spi': add driver mcp251x
[    0.937500] bus: 'spi': driver_probe_device: matched device spi32766.2 with driver mcp251x
[    0.937500] bus: 'spi': really_probe: probing driver mcp251x with device spi32766.2
[    0.937500] mcp251x spi32766.2: no sleep pinctrl state
[    0.937500] mcp251x spi32766.2: no idle pinctrl state
[    0.937500] mcp251x: probe of spi32766.2 failed with error -2
[    0.945312] bus: 'platform': add driver macb
[    0.945312] bus: 'platform': driver_probe_device: matched device f802c000.ethernet with driver macb
[    0.945312] bus: 'platform': really_probe: probing driver macb with device f802c000.ethernet
[    0.945312] macb f802c000.ethernet: no sleep pinctrl state
[    0.945312] macb f802c000.ethernet: no idle pinctrl state
[    0.945312] device: 'eth0': device_add
[    0.945312] PM: Adding info for No Bus:eth0
[    0.945312] device: 'f802c000.etherne': device_add
[    0.945312] PM: Adding info for No Bus:f802c000.etherne
[    0.945312] libphy: MACB_mii_bus: probed
[    0.953125] device: 'f802c000.etherne:01': device_add
[    0.953125] bus: 'mdio_bus': add device f802c000.etherne:01
[    0.953125] PM: Adding info for mdio_bus:f802c000.etherne:01
[    0.953125] bus: 'mdio_bus': driver_probe_device: matched device f802c000.etherne:01 with driver SMSC LAN8710/LAN8720
[    0.953125] bus: 'mdio_bus': really_probe: probing driver SMSC LAN8710/LAN8720 with device f802c000.etherne:01
[    0.953125] SMSC LAN8710/LAN8720 f802c000.etherne:01: no default pinctrl state
[    0.953125] driver: 'f802c000.etherne:01': driver_bound: bound to device 'SMSC LAN8710/LAN8720'
[    0.953125] bus: 'mdio_bus': really_probe: bound device f802c000.etherne:01 to driver SMSC LAN8710/LAN8720
[    1.031250] macb f802c000.ethernet eth0: Cadence MACB at 0xf802c000 irq 27 (00:11:22:33:44:55)
[    1.039062] macb f802c000.ethernet eth0: attached PHY driver [SMSC LAN8710/LAN8720] (mii_bus:phy_addr=f802c000.etherne:01, irq=-1)
[    1.046875] driver: 'f802c000.ethernet': driver_bound: bound to device 'macb'
[    1.046875] bus: 'platform': really_probe: bound device f802c000.ethernet to driver macb
[    1.046875] bus: 'platform': add driver smc91x
[    1.046875] bus: 'platform': add driver smc911x
[    1.046875] bus: 'platform': add driver smsc911x
[    1.046875] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.054687] ehci-atmel: EHCI Atmel driver
[    1.062500] bus: 'platform': add driver atmel-ehci
[    1.062500] bus: 'platform': driver_probe_device: matched device 700000.ehci with driver atmel-ehci
[    1.062500] bus: 'platform': really_probe: probing driver atmel-ehci with device 700000.ehci
[    1.062500] atmel-ehci 700000.ehci: no default pinctrl state
[    1.062500] atmel-ehci 700000.ehci: EHCI Host Controller
[    1.070312] atmel-ehci 700000.ehci: new USB bus registered, assigned bus number 1
[    1.078125] atmel-ehci 700000.ehci: irq 28, io mem 0x00700000
[    1.093750] atmel-ehci 700000.ehci: USB 2.0 started, EHCI 1.00
[    1.093750] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    1.101562] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.109375] usb usb1: Product: EHCI Host Controller
[    1.117187] usb usb1: Manufacturer: Linux 3.14.0-rc4+ ehci_hcd
[    1.117187] usb usb1: SerialNumber: 700000.ehci
[    1.125000] device: 'usb1': device_add
[    1.125000] bus: 'usb': add device usb1
[    1.125000] PM: Adding info for usb:usb1
[    1.125000] bus: 'usb': driver_probe_device: matched device usb1 with driver usb
[    1.125000] bus: 'usb': really_probe: probing driver usb with device usb1
[    1.125000] usb usb1: no default pinctrl state
[    1.125000] device: '1-0:1.0': device_add
[    1.125000] bus: 'usb': add device 1-0:1.0
[    1.125000] PM: Adding info for usb:1-0:1.0
[    1.125000] bus: 'usb': driver_probe_device: matched device 1-0:1.0 with driver hub
[    1.125000] bus: 'usb': really_probe: probing driver hub with device 1-0:1.0
[    1.125000] hub 1-0:1.0: no default pinctrl state
[    1.125000] hub 1-0:1.0: USB hub found
[    1.132812] hub 1-0:1.0: 3 ports detected
[    1.132812] device: 'port1': device_add
[    1.132812] PM: Adding info for No Bus:port1
[    1.132812] device: 'port2': device_add
[    1.132812] PM: Adding info for No Bus:port2
[    1.132812] device: 'port3': device_add
[    1.132812] PM: Adding info for No Bus:port3
[    1.140625] driver: '1-0:1.0': driver_bound: bound to device 'hub'
[    1.140625] bus: 'usb': really_probe: bound device 1-0:1.0 to driver hub
[    1.140625] device: 'ep_81': device_add
[    1.140625] PM: Adding info for No Bus:ep_81
[    1.140625] driver: 'usb1': driver_bound: bound to device 'usb'
[    1.140625] bus: 'usb': really_probe: bound device usb1 to driver usb
[    1.140625] device: 'ep_00': device_add
[    1.140625] PM: Adding info for No Bus:ep_00
[    1.140625] driver: '700000.ehci': driver_bound: bound to device 'atmel-ehci'
[    1.140625] bus: 'platform': really_probe: bound device 700000.ehci to driver atmel-ehci
[    1.140625] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.140625] ohci-atmel: OHCI Atmel driver
[    1.148437] bus: 'platform': add driver at91_ohci
[    1.148437] bus: 'platform': driver_probe_device: matched device 600000.ohci with driver at91_ohci
[    1.148437] bus: 'platform': really_probe: probing driver at91_ohci with device 600000.ohci
[    1.148437] at91_ohci 600000.ohci: no default pinctrl state
[    1.148437] at91_ohci 600000.ohci: OHCI Host Controller
[    1.156250] at91_ohci 600000.ohci: new USB bus registered, assigned bus number 2
[    1.164062] at91_ohci 600000.ohci: irq 28, io mem 0x00600000
[    1.226562] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    1.234375] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.242187] usb usb2: Product: OHCI Host Controller
[    1.242187] usb usb2: Manufacturer: Linux 3.14.0-rc4+ ohci_hcd
[    1.250000] usb usb2: SerialNumber: at91
[    1.257812] device: 'usb2': device_add
[    1.257812] bus: 'usb': add device usb2
[    1.257812] PM: Adding info for usb:usb2
[    1.257812] bus: 'usb': driver_probe_device: matched device usb2 with driver usb
[    1.257812] bus: 'usb': really_probe: probing driver usb with device usb2
[    1.257812] usb usb2: no default pinctrl state
[    1.257812] device: '2-0:1.0': device_add
[    1.257812] bus: 'usb': add device 2-0:1.0
[    1.257812] PM: Adding info for usb:2-0:1.0
[    1.257812] bus: 'usb': driver_probe_device: matched device 2-0:1.0 with driver hub
[    1.257812] bus: 'usb': really_probe: probing driver hub with device 2-0:1.0
[    1.257812] hub 2-0:1.0: no default pinctrl state
[    1.257812] hub 2-0:1.0: USB hub found
[    1.265625] hub 2-0:1.0: 3 ports detected
[    1.265625] device: 'port1': device_add
[    1.265625] PM: Adding info for No Bus:port1
[    1.265625] device: 'port2': device_add
[    1.265625] PM: Adding info for No Bus:port2
[    1.265625] device: 'port3': device_add
[    1.265625] PM: Adding info for No Bus:port3
[    1.265625] driver: '2-0:1.0': driver_bound: bound to device 'hub'
[    1.265625] bus: 'usb': really_probe: bound device 2-0:1.0 to driver hub
[    1.265625] device: 'ep_81': device_add
[    1.265625] PM: Adding info for No Bus:ep_81
[    1.265625] driver: 'usb2': driver_bound: bound to device 'usb'
[    1.265625] bus: 'usb': really_probe: bound device usb2 to driver usb
[    1.265625] device: 'ep_00': device_add
[    1.265625] PM: Adding info for No Bus:ep_00
[    1.265625] driver: '600000.ohci': driver_bound: bound to device 'at91_ohci'
[    1.265625] bus: 'platform': really_probe: bound device 600000.ohci to driver at91_ohci
[    1.265625] bus: 'usb': add driver usb-storage
[    1.273437] usbcore: registered new interface driver usb-storage
[    1.273437] bus: 'platform': add driver at91_rtc
[    1.273437] bus: 'platform': driver_probe_device: matched device fffffeb0.rtc with driver at91_rtc
[    1.273437] bus: 'platform': really_probe: probing driver at91_rtc with device fffffeb0.rtc
[    1.273437] at91_rtc fffffeb0.rtc: no default pinctrl state
[    1.273437] device: 'rtc0': device_add
[    1.273437] PM: Adding info for No Bus:rtc0
[    1.281250] at91_rtc fffffeb0.rtc: rtc core: registered fffffeb0.rtc as rtc0
[    1.281250] at91_rtc fffffeb0.rtc: AT91 Real Time Clock driver.
[    1.289062] driver: 'fffffeb0.rtc': driver_bound: bound to device 'at91_rtc'
[    1.289062] bus: 'platform': really_probe: bound device fffffeb0.rtc to driver at91_rtc
[    1.289062] bus: 'platform': add driver rtc-at91sam9
[    1.289062] i2c /dev entries driver
[    1.296875] device class 'i2c-dev': registering
[    1.296875] device: 'i2c-0': device_add
[    1.296875] PM: Adding info for No Bus:i2c-0
[    1.296875] device: 'i2c-1': device_add
[    1.296875] PM: Adding info for No Bus:i2c-1
[    1.296875] bus: 'platform': add driver at91_wdt
[    1.296875] bus: 'platform': remove driver at91_wdt
[    1.296875] driver: 'at91_wdt': driver_release
[    1.296875] bus: 'mmc': add driver mmcblk
[    1.296875] bus: 'spi': add driver mmc_spi
[    1.296875] bus: 'platform': add driver leds-gpio
[    1.296875] bus: 'platform': driver_probe_device: matched device leds.3 with driver leds-gpio
[    1.296875] bus: 'platform': really_probe: probing driver leds-gpio with device leds.3
[    1.296875] leds-gpio leds.3: no default pinctrl state
[    1.296875] device: 'module_led': device_add
[    1.304687] PM: Adding info for No Bus:module_led
[    1.304687] device: 'cpu_led': device_add
[    1.304687] PM: Adding info for No Bus:cpu_led
[    1.304687] device: 'busy_led': device_add
[    1.304687] PM: Adding info for No Bus:busy_led
[    1.304687] device: 'fail_led': device_add
[    1.304687] PM: Adding info for No Bus:fail_led
[    1.304687] driver: 'leds.3': driver_bound: bound to device 'leds-gpio'
[    1.304687] bus: 'platform': really_probe: bound device leds.3 to driver leds-gpio
[    1.304687] bus: 'hid': registered
[    1.304687] bus: 'hid': add driver hid-generic
[    1.304687] bus: 'usb': add driver usbhid
[    1.304687] usbcore: registered new interface driver usbhid
[    1.312500] usbhid: USB HID core driver
[    1.320312] TCP: cubic registered
[    1.320312] NET: Registered protocol family 17
[    1.328125] can: controller area network core (rev 20120528 abi 9)
[    1.335937] NET: Registered protocol family 29
[    1.335937] can: raw protocol (rev 20120528)
[    1.343750] can: broadcast manager protocol (rev 20120528 t)
[    1.343750] device: 'cpu_dma_latency': device_add
[    1.343750] PM: Adding info for No Bus:cpu_dma_latency
[    1.351562] device: 'network_latency': device_add
[    1.351562] PM: Adding info for No Bus:network_latency
[    1.351562] device: 'network_throughput': device_add
[    1.351562] PM: Adding info for No Bus:network_throughput
[    1.351562] device class 'ubi': registering
[    1.351562] device: 'ubi_ctrl': device_add
[    1.351562] PM: Adding info for No Bus:ubi_ctrl
[    1.351562] bus: 'platform': add driver gpio-keys
[    1.351562] bus: 'platform': driver_probe_device: matched device gpio_keys.4 with driver gpio-keys
[    1.351562] bus: 'platform': really_probe: probing driver gpio-keys with device gpio_keys.4
[    1.351562] gpio-keys gpio_keys.4: no default pinctrl state
[    1.351562] device: 'input0': device_add
[    1.351562] PM: Adding info for No Bus:input0
[    1.351562] input: gpio_keys.4 as /devices/gpio_keys.4/input/input0
[    1.359375] device: 'event0': device_add
[    1.359375] PM: Adding info for No Bus:event0
[    1.359375] evbug: Connected device: input0 (gpio_keys.4 at gpio-keys/input0)
[    1.359375] driver: 'gpio_keys.4': driver_bound: bound to device 'gpio-keys'
[    1.359375] bus: 'platform': really_probe: bound device gpio_keys.4 to driver gpio-keys
[    1.367187] at91_rtc fffffeb0.rtc: setting system clock to 2014-02-26 09:47:03 UTC (1393408023)
[    1.375000] bus: 'platform': add driver atmel_mci
[    1.375000] bus: 'platform': driver_probe_device: matched device f0008000.mmc with driver atmel_mci
[    1.375000] bus: 'platform': really_probe: probing driver atmel_mci with device f0008000.mmc
[    1.375000] atmel_mci f0008000.mmc: no sleep pinctrl state
[    1.375000] atmel_mci f0008000.mmc: no idle pinctrl state
[    1.375000] atmel_mci f0008000.mmc: version: 0x504
[    1.375000] atmel_mci f0008000.mmc: using dma0chan4 for DMA transfers
[    1.382812] device: 'mmc0': device_add
[    1.382812] PM: Adding info for No Bus:mmc0
[    1.429687] atmel_mci f0008000.mmc: Atmel MCI controller at 0xf0008000 irq 22, 1 slots
[    1.437500] driver: 'f0008000.mmc': driver_bound: bound to device 'atmel_mci'
[    1.437500] bus: 'platform': really_probe: bound device f0008000.mmc to driver atmel_mci
[    3.031250] macb f802c000.ethernet eth0: link up (100/Full)
[    3.054687] IP-Config: Guessing netmask 255.0.0.0
[    3.054687] IP-Config: Complete:
[    3.054687]      device=eth0, hwaddr=00:11:22:33:44:55, ipaddr=10.185.5.102, mask=255.0.0.0, gw=255.255.255.255
[    3.062500]      host=10.185.5.102, domain=, nis-domain=(none)
[    3.070312]      bootserver=255.255.255.255, rootserver=10.185.5.4, rootpath=
[    3.101562] device: '0:11': device_add
[    3.101562] PM: Adding info for No Bus:0:11
[    3.101562] VFS: Mounted root (nfs filesystem) on device 0:11.
[    3.109375] devtmpfs: mounted
[    3.109375] Freeing unused kernel memory: 136K (c048b000 - c04ad000)
[    3.796875] random: dd urandom read with 21 bits of entropy available
[   45.789062] random: nonblocking pool is initialized

--------------030308070308080908040809
Content-Type: text/plain; charset=UTF-8;
 name="mymachine.dts"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="mymachine.dts"

LyoKICogbXltYWNoaW5lLmR0cyAtIERldmljZSBUcmVlIGZpbGUgZm9yIGJvYXJkLCBiYXNl
IEFUOTFzYW05ZzI1CiAqIAkJCQkJCQkgIC0gQm9hcmQgcmV2IFYxUjEKICoKICogQ29weXJp
Z2h0IChDKSAyMDE0IEx1Y2FzIFphbXBhciBCZXJuYXJkaSA8bHVjYXMuemFtcGFyQGdtYWls
LmNvbT4KICoKICogTGljZW5zZWQgdW5kZXIgR1BMdjIgb3IgbGF0ZXIuCiAqLwovZHRzLXYx
LzsKI2luY2x1ZGUgImF0OTFzYW05ZzI1LmR0c2kiCgovIHsKCW1vZGVsID0gIk15TWFjaGlu
ZSI7Cgljb21wYXRpYmxlID0gInphbXBhcixteW1hY2hpbmUtdjFyMSIsICJhdG1lbCxhdDkx
c2FtOXg1ZWsiLAoJCSAgICAgImF0bWVsLGF0OTFzYW05eDUiLCAiYXRtZWwsYXQ5MXNhbTki
OwoKCWFsaWFzZXMgewoJCXNlcmlhbDAgPSAmZGJndTsKCQlzZXJpYWwxID0gJnVzYXJ0MDsK
CQlzZXJpYWwyID0gJnVzYXJ0MTsKCQlzZXJpYWwzID0gJnVzYXJ0MjsKCQlzZXJpYWw0ID0g
JnVzYXJ0MzsKCQlzZXJpYWw1ID0gJnVhcnQwOwoJCXNlcmlhbDYgPSAmdWFydDE7Cgl9OwoK
CWNob3NlbiB7CgkJYm9vdGFyZ3MgPSAiY29uc29sZT10dHlTMCwxMTUyMDAgZWFybHlwcmlu
dGsgbXRkcGFydHM9YXRtZWxfbmFuZDoyNTZrKGJvb3RzdHJhcClybyw1MTJrKHVib290KXJv
LDI1NmsoZW52KSwyNTZrKGVudl9yZWR1bmRhbnQpLDI1Nmsoc3BhcmUpLDUxMmsoZHRiKSw2
TShrZXJuZWwpcm8sLShyb290ZnMpIHJvb3Rmc3R5cGU9dWJpZnMgdWJpLm10ZD03IHJvb3Q9
dWJpMDpyb290ZnMgcnciOwoJfTsKCgltZW1vcnkgewoJCS8qIDEyOCBNQiwgY2hhbmdlIHRo
aXMgZm9yIDI1NiBNQiByZXZpc2lvbiAqLwoJCXJlZyA9IDwweDIwMDAwMDAwIDB4ODAwMDAw
MD47Cgl9OwoKCQkKCWNsb2NrcyB7CgkJI2FkZHJlc3MtY2VsbHMgPSA8MT47CgkJI3NpemUt
Y2VsbHMgPSA8MT47CgkJcmFuZ2VzOwoKCQltYWluX2Nsb2NrOiBjbG9ja0AwIHsKCQkJY29t
cGF0aWJsZSA9ICJhdG1lbCxvc2MiLCAiZml4ZWQtY2xvY2siOwoJCQljbG9jay1mcmVxdWVu
Y3kgPSA8MTIwMDAwMDA+OwoJCX07CgoJCW1jcDI1MTVfY2xvY2s6IG1jcDI1NTE1X2Nsb2Nr
IHsKCQkJY29tcGF0aWJsZSA9ICJmaXhlZC1jbG9jayI7CgkJCSNjbG9jay1jZWxscyA9IDww
PjsKCQkJY2xvY2stZnJlcXVlbmN5ID0gPDIwMDAwMDAwPjsKCQkKCX07CgoKCX07CgkJCglh
aGIgewoJCWFwYiB7CgkJCW1tYzA6IG1tY0BmMDAwODAwMCB7CgkJCQkvKiBOLkIuIEFyaWEg
aGFzIG5vIFNEIGNhcmQgZGV0ZWN0IChDRCksIGFzc3VtZWQgcHJlc2VudCAqLwoKCQkJCXBp
bmN0cmwtMCA9IDwKCQkJCQkmcGluY3RybF9tbWMwX3Nsb3QwX2Nsa19jbWRfZGF0MAoJCQkJ
CSZwaW5jdHJsX21tYzBfc2xvdDBfZGF0MV8zPjsKCQkJCXN0YXR1cyA9ICJva2F5IjsKCQkJ
CXNsb3RAMCB7CgkJCQkJcmVnID0gPDA+OwoJCQkJCWJ1cy13aWR0aCA9IDw0PjsKCQkJCX07
CgkJCX07CgoJCQlpMmMwOiBpMmNAZjgwMTAwMDAgewoJCQkJc3RhdHVzID0gIm9rYXkiOwoJ
CQkJCgkJCQkJMjRjNTEyQDUwIHsKCQkJCQljb21wYXRpYmxlID0gIjI0YzUxMiI7CgkJCQkJ
cmVnID0gPDB4NTA+OwoJCQkJCXBhZ2VzaXplID0gPDEyOD47CgkJCQkJfTsKCQkJfTsKCgkJ
CWkyYzE6IGkyY0BmODAxNDAwMCB7CgkJCQlzdGF0dXMgPSAib2theSI7CgkJCX07CgoJCQkv
KiBUV0QyK1RDTEsyIGhpZGRlbiBiZWhpbmQgZXRoZXJuZXQsIHNvIG5vIGkyYzIgKi8KCgkJ
CXVzYXJ0MDogc2VyaWFsQGY4MDFjMDAwIHsKCQkJCXBpbmN0cmwtMCA9IDwmcGluY3RybF91
c2FydDAKCQkJCQkgICAgICZwaW5jdHJsX3VzYXJ0MF9ydHMKCQkJCQkgICAgICZwaW5jdHJs
X3VzYXJ0MF9jdHM+OwoJCQkJc3RhdHVzID0gImRpc2FibGVkIjsKCQkJfTsKCgkJCXVzYXJ0
MTogc2VyaWFsQGY4MDIwMDAwIHsKCQkJCXBpbmN0cmwtMCA9IDwmcGluY3RybF91c2FydDEK
CQkJCQkgICAgIC8qICZwaW5jdHJsX3VzYXJ0MV9ydHMgKi8KCQkJCQkgICAgIC8qICZwaW5j
dHJsX3VzYXJ0MV9jdHMgKi8KCQkJCQkgICAgPjsKCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7
CgkJCX07CgoJCQl1c2FydDI6IHNlcmlhbEBmODAyNDAwMCB7CgkJCQkvKiBjYW5ub3QgYWN0
aXZhdGUgUlRTMitDVFMyLCBjbGFzaCB3aXRoCgkJCQkgKiBldGhlcm5ldCBvbiBQQjAgYW5k
IFBCMSAqLwoJCQkJcGluY3RybC0wID0gPCZwaW5jdHJsX3VzYXJ0Mj47CgkJCQlzdGF0dXMg
PSAiZGlzYWJsZWQiOwoJCQl9OwoKCQkJdXNhcnQzOiBzZXJpYWxAZjgwMjgwMDAgewoJCQkJ
Y29tcGF0aWJsZSA9ICJhdG1lbCxhdDkxc2FtOTI2MC11c2FydCI7CgkJCQlyZWcgPSA8MHhm
ODAyODAwMCAweDIwMD47CgkJCQlpbnRlcnJ1cHRzID0gPDggNCA1PjsKCQkJCXBpbmN0cmwt
bmFtZXMgPSAiZGVmYXVsdCI7CgkJCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfdXNhcnQzCgkJ
CQkJICAgICAvKiAmcGluY3RybF91c2FydDNfcnRzICovCgkJCQkJICAgICAvKiAmcGluY3Ry
bF91c2FydDNfY3RzICovCgkJCQkJICAgID47CgkJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOwoJ
CQl9OwoKCQkJbWFjYjA6IGV0aGVybmV0QGY4MDJjMDAwIHsKCQkJCXBoeS1tb2RlID0gInJt
aWkiOwoJCQkJLyoKCQkJCSAqIGZvbGxvd2luZyBjYW4gYmUgb3ZlcndyaXR0ZW4gYnkgYm9v
dGxvYWRlcjoKCQkJCSAqIGZvciBleGFtcGxlIHUtYm9vdCAnZnRkIHNldCcgY29tbWFuZAoJ
CQkJICovCgkJCQlsb2NhbC1tYWMtYWRkcmVzcyA9IFswMCAwMCAwMCAwMCAwMCAwMF07CgkJ
CQlzdGF0dXMgPSAib2theSI7CgkJCX07CgoJCQkvKgoJCQkgKiBVQVJUMC8xIHBpbnMgYXJl
IG1hcmtlZCBhcyBHUElPIG9uCgkJCSAqIEFyaWEgZG9jdW1lbnRhdGlvbi4KCQkJICogQ2hh
bmdlIHRvICJva2F5IiBpZiB5b3UgbmVlZCBhZGRpdGlvbmFsIHNlcmlhbCBwb3J0cwoJCQkg
Ki8KCQkJdWFydDA6IHNlcmlhbEBmODA0MDAwMCB7CgkJCQlzdGF0dXMgPSAiZGlzYWJsZWQi
OwoJCQl9OwoKCQkJdWFydDE6IHNlcmlhbEBmODA0NDAwMCB7CgkJCQlzdGF0dXMgPSAiZGlz
YWJsZWQiOwoJCQl9OwoKCQkJYWRjMDogYWRjQGY4MDRjMDAwIHsKCQkJCXN0YXR1cyA9ICJv
a2F5IjsKCQkJCWF0bWVsLGFkYy1jaGFubmVscy11c2VkID0gPDB4Zj47CgkJCQlhdG1lbCxh
ZGMtbnVtLWNoYW5uZWxzID0gPDQ+OwoJCQl9OwoKCQkJZGJndTogc2VyaWFsQGZmZmZmMjAw
IHsKCQkJCXN0YXR1cyA9ICJva2F5IjsKCQkJfTsKCgkJCXBpbmN0cmxAZmZmZmY0MDAgewoJ
CQkJdzFfMCB7CgkJCQkJcGluY3RybF93MV8wOiB3MV8wLTAgewoJCQkJCQlhdG1lbCxwaW5z
ID0gPDAgMjEgMHgwIDB4MT47IC8qIFBBMjEgUElPLCBwdWxsLXVwICovCgkJCQkJfTsKCgkJ
CQl9OwoJCQkJCgkJCQltY3AyNTF4XzAgewoJCQkJCXBpbmN0cmxfbWNwMjUxeF8wOiBtY3Ay
NTF4XzAtMCB7CgkJCQkJCWF0bWVsLHBpbnMgPSA8QVQ5MV9QSU9DIDEyIEFUOTFfUEVSSVBI
X0dQSU8gQVQ5MV9QSU5DVFJMX1BVTExfVVA+OwkJLyogUEMxMiBwZXJpcGggR1BJTyAtIElO
VCAqLwoJCQkJCX07CgkJCQl9OwoJCQkJCQoJCQkJCQoJCQl9OwoKCQkJcnRjQGZmZmZmZWIw
IHsKCQkJCXN0YXR1cyA9ICJva2F5IjsKCQkJfTsKCQkJCgkJCQoJCQlzcGkwOiBzcGlAZjAw
MDAwMDAgewoJCQkJc3RhdHVzID0gIm9rYXkiOwoJCQkJaW50ZXJydXB0cyA9IDwxMyA0IDU+
OwoJCQkJY3MtZ3Bpb3MgPSA8JnBpb0EgMTQgMD4sIDwmcGlvQSA3IDA+LCA8JnBpb0EgMSAw
PiwgPDA+OwoKICAgICAgIAkJCQoKICAgICAgICAJCQkKCQkJCW10ZF9kYXRhZmxhc2hAMCB7
CgkJCQkJY29tcGF0aWJsZSA9ICJhdG1lbCxhdDQ1IiwgImF0bWVsLGRhdGFmbGFzaCI7CgkJ
CQkJc3BpLW1heC1mcmVxdWVuY3kgPSA8MTAwMDAwMDA+OwoJCQkJCXJlZyA9IDwwPjsKCQkJ
CX07CgkJCQkKCQkJCWNhbjA6IGNhbkAxIHsKCQkJCQljb21wYXRpYmxlID0gIm1pY3JvY2hp
cCxtY3AyNTE1IjsKCQkJCQlyZWcgPSA8Mj47CgkJCQkJc3BpLW1heC1mcmVxdWVuY3kgPSA8
MTAwMDAwMDA+OwoJCQkJCWNsb2NrcyA9IDwmbWNwMjUxNV9jbG9jaz47CgkJCQkJcGluY3Ry
bC1uYW1lcyA9ICJkZWZhdWx0IjsKCQkJCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfbWNwMjUx
eF8wPjsKCQkJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZwaW9DPjsKCQkJCQlpbnRlcnJ1cHRz
ID0gPDEyIDI+OwoJCQkJfTsKCQl9OwoKCX07CgkKCQl1c2IwOiBvaGNpQDAwNjAwMDAwIHsK
CQkJc3RhdHVzID0gIm9rYXkiOwoJCQludW0tcG9ydHMgPSA8Mz47CgkJfTsKCgkJdXNiMTog
ZWhjaUAwMDcwMDAwMCB7CgkJCXN0YXR1cyA9ICJva2F5IjsKCQl9OwoJCQoJCW5hbmQwOiBu
YW5kQDQwMDAwMDAwIHsKCQkJbmFuZC1idXMtd2lkdGggPSA8OD47CgkJCW5hbmQtZWNjLW1v
ZGUgPSAiaHciOwoJCQlhdG1lbCxoYXMtcG1lY2M7CS8qIEVuYWJsZSBQTUVDQyAqLwoJCQlh
dG1lbCxwbWVjYy1jYXAgPSA8Mj47CgkJCWF0bWVsLHBtZWNjLXNlY3Rvci1zaXplID0gPDUx
Mj47CgkJCW5hbmQtb24tZmxhc2gtYmJ0OwoJCQlzdGF0dXMgPSAib2theSI7CgoJCQlhdDkx
Ym9vdHN0cmFwQDAgewoJCQkJbGFiZWwgPSAiYXQ5MWJvb3RzdHJhcCI7CgkJCQlyZWcgPSA8
MHgwIDB4NDAwMDA+OwoJCQl9OwoKCQkJdWJvb3RANDAwMDAgewoJCQkJbGFiZWwgPSAidS1i
b290IjsKCQkJCXJlZyA9IDwweDQwMDAwIDB4ODAwMDA+OwoJCQl9OwoKCQkJdWJvb3RlbnZA
YzAwMDAgewoJCQkJbGFiZWwgPSAiVS1Cb290IEVudiI7CgkJCQlyZWcgPSA8MHhjMDAwMCAw
eDE0MDAwMD47CgkJCX07CgoJCQlrZXJuZWxAMjAwMDAwIHsKCQkJCWxhYmVsID0gImtlcm5l
bCI7CgkJCQlyZWcgPSA8MHgyMDAwMDAgMHg2MDAwMDA+OwoJCQl9OwoKCQkJcm9vdGZzQDgw
MDAwMCB7CgkJCQlsYWJlbCA9ICJyb290ZnMiOwoJCQkJcmVnID0gPDB4ODAwMDAwIDB4MWY4
MDAwMDA+OwoJCQl9OwoJCX07CgkJCgl9OwoKCWxlZHMgewoJCWNvbXBhdGlibGUgPSAiZ3Bp
by1sZWRzIjsKCgkJLyogbGl0dGxlIGdyZWVuIExFRCBpbiBtaWRkbGUgb2YgY3B1IG1vZHVs
ZSAqLwoJCW1vZHVsZV9sZWQgewoJCQlsYWJlbCA9ICJtb2R1bGVfbGVkIjsKCQkJZ3Bpb3Mg
PSA8JnBpb0IgOCBHUElPX0FDVElWRV9ISUdIPjsgLyogUEI4ICovCgkJCWxpbnV4LGRlZmF1
bHQtdHJpZ2dlciA9ICJoZWFydGJlYXQiOwoJCX07CgoJCWNwdV9sZWQgewoJCQlsYWJlbCA9
ICJjcHVfbGVkIjsKCQkJZ3Bpb3MgPSA8JnBpb0EgMjkgR1BJT19BQ1RJVkVfSElHSD47IC8q
IFBBMjkgKi8KCQkJbGludXgsZGVmYXVsdC10cmlnZ2VyID0gImhlYXJ0YmVhdCI7CgkJfTsK
CgkJYnVzeV9sZWQgewoJCQlsYWJlbCA9ICJidXN5X2xlZCI7CgkJCWdwaW9zID0gPCZwaW9B
IDI4IEdQSU9fQUNUSVZFX0hJR0g+OyAvKiBQQTI4ICovCgkJCWxpbnV4LGRlZmF1bHQtdHJp
Z2dlciA9ICJoZWFydGJlYXQiOwoJCX07CgkJCgkJZmFpbF9sZWQgewoJCQlsYWJlbCA9ICJm
YWlsX2xlZCI7CgkJCWdwaW9zID0gPCZwaW9BIDI3IEdQSU9fQUNUSVZFX0hJR0g+OyAvKiBQ
QTI3ICovCgkJCWxpbnV4LGRlZmF1bHQtdHJpZ2dlciA9ICJoZWFydGJlYXQiOwoJCX07CgkJ
CQkKCX07CgkKCWdwaW9fa2V5cyB7CgkJY29tcGF0aWJsZSA9ICJncGlvLWtleXMiOwoKCQl0
cmFuc2Zlcl9idXR0b24gewoJCQlsYWJlbCA9ICJ0cmFuc2Zlcl9idXR0b24iOwoJCQlncGlv
cyA9IDwmcGlvQSAyNiBHUElPX0FDVElWRV9MT1c+OwoJCQlsaW51eCxjb2RlID0gPDE4Mz47
IC8qIEYxMyBLZXkgKi8KCQkJZ3Bpby1rZXksd2FrZXVwOwoJCX07CgoJCWN1c3RvbV9idXR0
b24gewoJCQlsYWJlbCA9ICJjdXN0b21fYnV0dG9uIjsKCQkJZ3Bpb3MgPSA8JnBpb0EgMjUg
R1BJT19BQ1RJVkVfTE9XPjsKCQkJbGludXgsY29kZSA9IDwxODQ+OyAvKiBGMTQgS2V5ICov
CgkJCWdwaW8ta2V5LHdha2V1cDsKCQl9OwoJfTsKCQoKCW9uZXdpcmVAMCB7CgkJY29tcGF0
aWJsZSA9ICJ3MS1ncGlvIjsKCQlncGlvcyA9IDwmcGlvQSAyMSBHUElPX0FDVElWRV9MT1c+
OwoJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7CgkJcGluY3RybC0wID0gPCZwaW5jdHJs
X3cxXzA+OwoJfTsKfTsK
--------------030308070308080908040809--
