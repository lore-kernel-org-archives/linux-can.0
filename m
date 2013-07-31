From: Jeffrey Lin <linjef@gmail.com>
Subject: Re: AW: [Socketcan-users] [socketcan]problem to using CAN with BeagleBone Black A5A
Date: Wed, 31 Jul 2013 09:23:12 +0000 (UTC)
Message-ID: <loom.20130731T112310-856@post.gmane.org>
References: <zarafa.51b23885.159b.07db93856850360d@v14647.1blu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:35422 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759349Ab3GaJZF (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Wed, 31 Jul 2013 05:25:05 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glc-linux-can2@m.gmane.org>)
	id 1V4SeV-0006XO-67
	for linux-can@vger.kernel.org; Wed, 31 Jul 2013 11:25:03 +0200
Received: from hobohome.Stanford.EDU ([128.12.164.251])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 31 Jul 2013 11:25:03 +0200
Received: from linjef by hobohome.Stanford.EDU with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-can@vger.kernel.org>; Wed, 31 Jul 2013 11:25:03 +0200
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

Michael Luxen <mluxen <at> gmx.net> writes:
> Hello Mohamed,
> 
> is you question still open or answered already?
> 
> If still open, please have a look on this page where you can find how to 
enable the CAN-Devices on BeagleBone Black.
> http://www.aero-box.co.uk/beaglebone-black#TOC-Enable-CANbus-device
> 
> The only thing you have to do is to edit the am335x-bone-common.dtsi file 
for enabling dcan0 and/or dcan1.
> Please have in mind that dcan0 is normaly used for the optional Capes, as 
they use the I2C2 pins which are
> muxed on the same pins than dcan0.
> Nevertheless I've edited am335x-bone-common.dtsi successfully to enable 
dcan0 and dcan1. On my
> BeagleBone Black (Hardware A5A) eveything is running fine on both internal 
CAN-Interfaces with latest
> Angstrom and latest Debian as well.
> Keep in mind that you have to put a CAN-transceiver on the Pins 20/19 
(DCAN0) an 24/26 (DCAN1) on your
> BeagleBone Black.
> 
> Regards
> Mike

Hi Mike: 

I have a similar question to Mohamed, and I'm not sure it was resolved in 
the following threads. 

I don't mind losing i2c2, so what I did was follow the http://www.aero-
box.co.uk/beaglebone-black#TOC-Enable-CANbus-device page, except since I 
want both dcan0 and dcan1, I removed the entry: 

                i2c2_pins: pinmux_i2c2_pins {
			pinctrl-single,pins = <
				0x178 0x73 	
				0x17c 0x73	

			>;
		};

and replaced it with 

                dcan0_pins: pinmux_dcan0_pins {
			pinctrl-single,pins = <
				0x178 0x12
				0x17c 0x32
			>; 

		};

		dcan1_pins: pinmux_dcan1_pins {
			pinctrl-single,pins = <
				0x180 0x12
				0x184 0x32
			>; 
		}; 

Then, as with the tutorial, made: 

                uart2: serial@48022000 {
                        status = "disabled";

                };

and added in: 

		dcan1: d_can@481d0000 {
			status = "okay";
			pinctrl-names = "default"; 
			pinctrl-0 = <&dcan1_pins>;  
		};

		dcan0: d_can@481cc000 {
			status = "okay"; 
			pinctrl-names = "default"; 
			pinctrl-0 = <&dcan0_pins>; 
		};  

In the spirit of stripping out all the i2c2 references, I got ride of 

&i2c2 {
	status = "okay";
	pinctrl-names = "default";
	pinctrl-0 = <&i2c2_pins>;

	clock-frequency = <100000>;

	cape_eeprom0: cape_eeprom0@54 {
		compatible = "at,24c256";
		reg = <0x54>;
	};

	cape_eeprom1: cape_eeprom1@55 {
		compatible = "at,24c256";
		reg = <0x55>;
	};

	cape_eeprom2: cape_eeprom2@56 {
		compatible = "at,24c256";
		reg = <0x56>;
	};

	cape_eeprom3: cape_eeprom3@57 {
		compatible = "at,24c256";
		reg = <0x57>;
	};
};

as well. 

I can bring up can0, but not can1: 

root@beaglebone:~# canconfig can0 bitrate 10000 ctrlmode triple-sampling on
can0 bitrate: 10000, sample-point: 0.875
can0 ctrlmode: loopback[OFF], listen-only[OFF], tripple-sampling[ON],one-
shot[OFF], berr-reporting[OFF]
root@beaglebone:~# canconfig can0 start
can0 state: ERROR-ACTIVE
root@beaglebone:~# canconfig can1 bitrate 10000 ctrlmode triple-sampling on
can1: failed to get bitrate

root@beaglebone:~# canconfig can1 stop
can1: failed to get state
root@beaglebone:~# canconfig can1 start
can1: failed to get state

I think I'm fundamentally missing something; do you have any pointers on 
this? 

Thanks!
Jeff


