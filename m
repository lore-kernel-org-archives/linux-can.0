From: =?utf-8?Q?Michael_Luxen?= <mluxen@gmx.net>
Subject: AW: [Socketcan-users] [socketcan]problem to using CAN with
 BeagleBone Black A5A
Date: Thu, 1 Aug 2013 00:45:25 +0200
Message-ID: <zarafa.51f99385.60f0.036c2a1e097ab32f@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from v14647.1blu.de ([178.254.6.47]:57767 "EHLO v14647.1blu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757781Ab3GaWzK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 31 Jul 2013 18:55:10 -0400
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: =?utf-8?Q?linux-can=40vger=2Ekernel=2Eorg?= <linux-can@vger.kernel.org>, =?utf-8?Q?Jeffrey_Lin?= <linjef@gmail.com>

Hello Jeffrey,
 
> I have a similar question to Mohamed, and I'm not sure it was resolved in 
> the following threads. 
> 
> I don't mind losing i2c2, so what I did was follow the http://www.aero-
> box.co.uk/beaglebone-black#TOC-Enable-CANbus-device page, except since I 
> want both dcan0 and dcan1, I removed the entry: 
> 
>                 i2c2_pins: pinmux_i2c2_pins {
> 			pinctrl-single,pins = <
> 				0x178 0x73 	
> 				0x17c 0x73	
> 
> 			>;
> 		};
It's not necessary to delete this lines if you disable the i2c2 later in the same file here:
----------------
&i2c2 {
	status = "disabled";
.
.
. 
----------------
> and replaced it with 
> 
>                 dcan0_pins: pinmux_dcan0_pins {
> 			pinctrl-single,pins = <
> 				0x178 0x12
> 				0x17c 0x32
> 			>; 
> 
> 		};
> 
> 		dcan1_pins: pinmux_dcan1_pins {
> 			pinctrl-single,pins = <
> 				0x180 0x12
> 				0x184 0x32
> 			>; 
> 		}; 
The dcan0/dcan1 settings are fine!
 
> Then, as with the tutorial, made: 
> 
>                 uart2: serial@48022000 {
>                         status = "disabled";
> 
>                 };
> 
> and added in: 
> 
> 		dcan1: d_can@481d0000 {
> 			status = "okay";
> 			pinctrl-names = "default"; 
> 			pinctrl-0 = <&dcan1_pins>;  
> 		};
> 
> 		dcan0: d_can@481cc000 {
> 			status = "okay"; 
> 			pinctrl-names = "default"; 
> 			pinctrl-0 = <&dcan0_pins>; 
> 		};  
Its also correct.
 
> In the spirit of stripping out all the i2c2 references, I got ride of 
> 
> &i2c2 {
> 	status = "okay";
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&i2c2_pins>;
> 
> 	clock-frequency = <100000>;
> 
> 	cape_eeprom0: cape_eeprom0@54 {
> 		compatible = "at,24c256";
> 		reg = <0x54>;
> 	};
> 
> 	cape_eeprom1: cape_eeprom1@55 {
> 		compatible = "at,24c256";
> 		reg = <0x55>;
> 	};
> 
> 	cape_eeprom2: cape_eeprom2@56 {
> 		compatible = "at,24c256";
> 		reg = <0x56>;
> 	};
> 
> 	cape_eeprom3: cape_eeprom3@57 {
> 		compatible = "at,24c256";
> 		reg = <0x57>;
> 	};
> };
Thats not necessary as mentioned above, you can only set status = "okay" to status = "disabled" but deleting the stuff should have the same result.

> I can bring up can0, but not can1: 
> 
> root@beaglebone:~# canconfig can0 bitrate 10000 ctrlmode triple-sampling on
> can0 bitrate: 10000, sample-point: 0.875
> can0 ctrlmode: loopback[OFF], listen-only[OFF], tripple-sampling[ON],one-
> shot[OFF], berr-reporting[OFF]
> root@beaglebone:~# canconfig can0 start
> can0 state: ERROR-ACTIVE
> root@beaglebone:~# canconfig can1 bitrate 10000 ctrlmode triple-sampling on
> can1: failed to get bitrate
> 
> root@beaglebone:~# canconfig can1 stop
> can1: failed to get state
> root@beaglebone:~# canconfig can1 start
> can1: failed to get state
> 
> I think I'm fundamentally missing something; do you have any pointers on 
> this? 
Did you use this dtc command line?
dtc -O dtb -o am335x-boneblack.dtb -b 0 am335x-boneblack.dts

I've seen an issue on my Debian based Beaglebone where the "-b 0" patch isn't available with my am335x-boneblack.dtb so can say it is a must to use the "-b 0" option.

DCAN0 seems to be OK. 
Can you provide the dmesg output for DCAN0 and DCAN1. Maybe there are some helpful information what happens during initialization.

Regards
Mike
