From: Lucas Zampar Bernardi <lucas.zampar@gmail.com>
Subject: Re: MCP2515 DTS support
Date: Sat, 22 Feb 2014 16:46:31 -0300
Message-ID: <5308FE97.8090804@gmail.com>
References: <144554558e0.2748.cbaa067694a7e68fb76a213b35423fb5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail-yh0-f50.google.com ([209.85.213.50]:58617 "EHLO
	mail-yh0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751661AbaBVTyb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sat, 22 Feb 2014 14:54:31 -0500
Received: by mail-yh0-f50.google.com with SMTP id 29so3815682yhl.37
        for <linux-can@vger.kernel.org>; Sat, 22 Feb 2014 11:54:31 -0800 (PST)
Received: from [10.185.5.4] ([201.74.250.127])
        by mx.google.com with ESMTPSA id g26sm32024482yhk.3.2014.02.22.11.46.33
        for <linux-can@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 22 Feb 2014 11:46:35 -0800 (PST)
In-Reply-To: <144554558e0.2748.cbaa067694a7e68fb76a213b35423fb5@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Hi again,


I found the causes of problem, and now I need to know if I was setting 
wrong structure or there are driver problem.
I've had this modification on mcp251x.c:

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
     dev_dbg(&spi->dev, "MCP2515: clk = devm_clk_get(&spi->dev, NULL)");
     if (IS_ERR(clk)) {
         if (pdata)
         {
             freq = pdata->oscillator_frequency;
         }
         else
         {
 >>        freq = 20 * 1000 * 1000;    // FORCE FREQUENCY to 20Mhz
             //return PTR_ERR(clk);
         }
     } else {
         dev_dbg(&spi->dev, "MCP2515: freq = clk_get_rate(clk);");
         freq = clk_get_rate(clk);
     }


Then the driver start to run.

I think that the problem is about how to set a correct clock.


I put on can node:
                 can0: can@1 {
                     compatible = "microchip,mcp2515";
                     reg = <2>;
                     spi-max-frequency = <5000000>;
                     clocks = <&mcp251x_clock>;
                     interrupt-parent = <&pioC>; /* MCP GPO Interrupt */
                     interrupts = <12 0x2>;
                 };



and my clocks node:

     clocks {
         #address-cells = <1>;
         #size-cells = <1>;
         ranges;

         main_clock: clock@0 {
             compatible = "atmel,osc", "fixed-clock";
             clock-frequency = <12000000>;
         };

         mcp251x_clock: mcp2515 {
             compatible = "fixed-clock";
             #clock-cells = <0>;
             clock-frequency = <20000000>;
         };


     };


So... How can we know if it's a DTS definition or a driver problem?




regards,



Lucas Zampar


On 21-02-2014 13:26, Lucas Zampar Bernardi wrote:
> Hello all,
>
>
>
> I have tried to communicate MCP2515 with new kernel 3.14-rc2 using 
> DTS. At this version, the driver has been modified to support DTS 
> structures.
>
> The hardware its ok, because it has worked witk linux 2.6.39.
>
> The SPI controller also it's ok, because I have an AT45DB321 connected 
> and its detected.
>
> Could somebody give some tips?
>
>
>
>
> My DTS SPI node:
>
>
>             spi0: spi@f0000000 {
>
>                 status = "okay";
>
>                 interrupts = <13 4 5>;
>
>                 cs-gpios = <&pioA 14 0>, <&pioA 7 0>, <&pioA 1 0>, 
> <0>; /* CHIP SELECT */
>
>
>
>
>
>                 mtd_dataflash@0 {
>
>                     compatible = "atmel,at45", "atmel,dataflash";
>
>                     spi-max-frequency = <1000000>;
>
>                     reg = <0>;
>
>                 };
>
>
>
>                 can0: can@1 {
>
>                     compatible = "microchip,mcp2515";
>
>                     reg = <2>;
>
>                     spi-max-frequency = <5000000>;
>
>                     clocks = <&mcp251x_clock>;
>
>                     interrupt-parent = <&pioC>; /* MCP GPO Interrupt */
>
>                     interrupts = <12 0x2>;
>
>                 };
>
>         };
>
>
>
> I have seen that the mcp2515 interrupt was not created.
>
>
> # cat /proc/interrupts
>
>            CPU0
>
> 16: 4817 AIC 1 at91_tick, at91_rtc, ttyS0
>
> 17: 81687 AIC 17 tc_clkevt
>
>  18:          0       AIC  20  at_hdmac
>
>  19:          0       AIC  21  at_hdmac
>
> 22: 21294 AIC 12 f0008000.mmc
>
> 23: 0 AIC 9 f8010000.i2c
>
> 24: 0 AIC 10 f8014000.i2c
>
> 26: 6 AIC 13 f0000000.spi
>
>  27:          0       AIC  24  eth0
>
>  28:          1       AIC  22  ehci_hcd:usb1, ohci_hcd:usb2
>
>  30:          1      GPIO  26  transfer_button
>
>  31:          0      GPIO  25  custom_button
>
> Err:          0
>
>
>
>
> # dmesg | grep spi
>
> [ 0.085937] bus: 'spi': registered
>
> [ 0.085937] device class 'spi_master': registering
>
> [ 0.101562] device: 'f0000000.spi': device_add
>
> [ 0.101562] bus: 'platform': add device f0000000.spi
>
> [ 0.101562] PM: Adding info for platform:f0000000.spi
>
> [ 0.703125] bus: 'spi': add driver mtd_dataflash
>
> [ 0.890625] bus: 'platform': add driver atmel_spi
>
> [ 0.890625] bus: 'platform': driver_probe_device: matched device 
> f0000000.spi with driver atmel_spi
>
> [ 0.890625] bus: 'platform': really_probe: probing driver atmel_spi 
> with device f0000000.spi
>
> [ 0.890625] atmel_spi f0000000.spi: no sleep pinctrl state
>
> [ 0.890625] atmel_spi f0000000.spi: no idle pinctrl state
>
> [ 0.890625] atmel_spi f0000000.spi: version: 0x212
>
> [ 0.898437] atmel_spi f0000000.spi: Using dma0chan2 (tx) and dma0chan3 
> (rx) for DMA transfers
>
> [ 0.906250] atmel_spi f0000000.spi: Atmel SPI Controller at 0xf0000000 
> (irq 26)
>
> [ 0.914062] device: 'spi32766': device_add
>
> [ 0.914062] PM: Adding info for No Bus:spi32766
>
> [ 0.914062] atmel_spi f0000000.spi: registered master spi32766 (dynamic)
>
> [ 0.914062] spi spi32766.0: setup: bpw 8 mode 0x0 -> csr0 00000002
>
> [ 0.914062] spi spi32766.0: setup mode 0, 8 bits/w, 1000000 Hz max --> 0
>
> [ 0.914062] device: 'spi32766.0': device_add
>
> [ 0.914062] bus: 'spi': add device spi32766.0
>
> [ 0.914062] PM: Adding info for spi:spi32766.0
>
> [ 0.914062] bus: 'spi': driver_probe_device: matched device spi32766.0 
> with driver mtd_dataflash
>
> [ 0.914062] bus: 'spi': really_probe: probing driver mtd_dataflash 
> with device spi32766.0
>
> [ 0.914062] mtd_dataflash spi32766.0: no default pinctrl state
>
> [ 0.914062] mtd_dataflash spi32766.0: new message c783fcb0 submitted 
> for spi32766.0
>
> [ 0.914062] mtd_dataflash spi32766.0: activate 14, mr 000e0031
>
> [ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc68: len 1 tx 
> c7869760 rx (null) bitpw 8
>
> [ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc8c: len 3 tx 
> (null) rx c7869761 bitpw 8
>
> [ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc8c: len 3 tx 
> (null) rx c7869761 bitpw 8
>
> [ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc8c: len 3 tx 
> (null) rx c7869761 bitpw 8
>
> [ 0.914062] mtd_dataflash spi32766.0: xfer c783fc68: len 1 tx 
> c7869760/00000000 rx (null)/00000000
>
> [ 0.914062] mtd_dataflash spi32766.0: xfer c783fc8c: len 3 tx 
> (null)/00000000 rx c7869761/00000000
>
> [ 0.914062] mtd_dataflash spi32766.0: DEactivate 14, mr 000f0031
>
> [ 0.914062] mtd_dataflash spi32766.0: new message c783fcb0 submitted 
> for spi32766.0
>
> [ 0.914062] mtd_dataflash spi32766.0: activate 14, mr 000e0031
>
> [ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc68: len 1 tx 
> c7869760 rx (null) bitpw 8
>
> [ 0.914062] atmel_spi f0000000.spi: start pio xfer c783fc8c: len 1 tx 
> (null) rx c7869761 bitpw 8
>
> [ 0.914062] mtd_dataflash spi32766.0: xfer c783fc68: len 1 tx 
> c7869760/00000000 rx (null)/00000000
>
> [ 0.914062] mtd_dataflash spi32766.0: xfer c783fc8c: len 1 tx 
> (null)/00000000 rx c7869761/00000000
>
> [ 0.914062] mtd_dataflash spi32766.0: DEactivate 14, mr 000f0031
>
> [ 0.914062] mtd_dataflash spi32766.0: AT45DB321x (4224 KBytes) 
> pagesize 528 bytes, OTP
>
> [ 0.929687] driver: 'spi32766.0': driver_bound: bound to device 
> 'mtd_dataflash'
>
> [ 0.929687] bus: 'spi': really_probe: bound device spi32766.0 to 
> driver mtd_dataflash
>
> [ 0.929687] atmel_spi f0000000.spi: registered child spi32766.0
>
> [ 0.929687] spi spi32766.2: setup: bpw 8 mode 0x0 -> csr2 00000002
>
> [ 0.929687] spi spi32766.2: setup mode 0, 8 bits/w, 5000000 Hz max --> 0
>
> [ 0.929687] device: 'spi32766.2': device_add
>
> [ 0.929687] bus: 'spi': add device spi32766.2
>
> [ 0.929687] PM: Adding info for spi:spi32766.2
>
> [ 0.929687] atmel_spi f0000000.spi: registered child spi32766.2
>
> [ 0.929687] driver: 'f0000000.spi': driver_bound: bound to device 
> 'atmel_spi'
>
> [ 0.929687] bus: 'platform': really_probe: bound device f0000000.spi 
> to driver atmel_spi
>
> [ 0.953125] bus: 'spi': add driver mcp251x
>
> [ 0.953125] bus: 'spi': driver_probe_device: matched device spi32766.2 
> with driver mcp251x
>
> [ 0.953125] bus: 'spi': really_probe: probing driver mcp251x with 
> device spi32766.2
>
> [ 0.953125] mcp251x spi32766.2: no default pinctrl state
>
> [ 0.953125] mcp251x: probe of spi32766.2 failed with error -2
>
> [ 1.328125] bus: 'spi': add driver mmc_spi
>
>
>
>
>
> Regards,
>
>
>
> Lucas Zampar
>
>

