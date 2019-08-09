From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: tcan4x5x on a Raspberry Pi
Date: Fri, 9 Aug 2019 21:49:48 +0200
Message-ID: <09c773a9-6b50-5633-c597-dcc67e938920@grandegger.com>
References: <845ea24f71b74b42821c7fce20bc0476@escrypt.com>
 <d1badcdb-7635-705d-35d5-448297e8fafa@ti.com>
 <ee351bd74b764759bb0258af3651bd4a@escrypt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <ee351bd74b764759bb0258af3651bd4a@escrypt.com>
Content-Language: en-GB
Sender: netdev-owner@vger.kernel.org
To: "FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu)" <fixed-term.Konstantin.Buecheler@escrypt.com>, Dan Murphy <dmurphy@ti.com>, "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
List-Id: linux-can.vger.kernel.org

Hello Konstantin,

m 09.08.19 um 18:46 schrieb FIXED-TERM Buecheler Konstantin
(ETAS-SEC/ECT-Mu):
> 
>> Konstantin
> 
>>> On 7/29/19 6:19 AM, FIXED-TERM Buecheler Konstantin (ETAS-SEC/ECT-Mu) wrote:
>>> Hi all,
>>>
>>> I am currently working on a project where I am trying to use the tcan4550 chip with a Raspberry PI 3B.
>>> I am struggling to create a working device tree overlay file for the Raspberry Pi.
>>> Has anyone here tried this already? I would appreciate any help.
> 
>> Are you using the driver from net-next?
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/drivers/net/can/m_can
> 
> Yes, I am using the driver from net-next. 
> 
> 
>> DT documentation here
> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git/tree/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
> 
> I saw this documentation but it didn’t help much (As I said, I don’t have much experience with device trees) . My dts file currently looks like this:  
> 
> /dts-v1/;
> /plugin/;
> 
> / {
>     compatible = "brcm,bcm2835", "brcm,bcm2836", "brcm,bcm2708", "brcm,bcm2709";
>     fragment@0 {
>         target = <&spi0>;
> 	__overlay__ {
>             status = "okay";
> 	    spidev@0{
> 	        status = "disabled";
> 	    };
> 	};
>     };
> 
>     fragment@2 {
>         compatible = "bosch, m_can";
> 	target = <&spi0>;
> 	__overlay__ {
> 	    tcan4x5x: tcan4x5x@0 {
> 	             compatible = "ti,tcan4x5x";
>                           reg = <0>;
> 		#address-cells = <1>;
>                          #size-cells = <1>;
> 		spi-max-frequency = <10000000>;
>                          bosch,mram-cfg = <0x0 0 0 32 0 0 1 1>;
> 		data-ready-gpios = <&gpio 23 0>;
> 		device-wake-gpios = <&gpio 24 1>;
> 				
> 	    };		
> 	};
>     };
> };
> 
> 
> Checking dmesg I always see these errors:
> [    5.409051] tcan4x5x spi0.0: no clock found
> [    5.409064] tcan4x5x spi0.0: no CAN clock source defined
> [    5.409125] tcan4x5x spi0.0: data-ready gpio not defined
> [    5.409135] tcan4x5x spi0.0: Probe failed, err=-22
> 
> I already fixed the clock issue once by doing something like this:
> clocks = <&can0_osc>,
>               <&can0_osc>;
> clock-names = "hclk", "cclk";
> But that didn’t fix the " data-ready gpio not defined" error.
> 
> 
>> I did the development on a BeagleBone Black.

Before fiddling with the dynamic device tree, I would try to patch
normal device tree source files first.

Wolfgang
