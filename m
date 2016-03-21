From: gianluca <gianlucarenzi@eurek.it>
Subject: Re: Testing CAN on Allwinner A20 / Banana Pi
Date: Mon, 21 Mar 2016 10:27:19 +0100
Message-ID: <56EFBE77.2020408@eurek.it>
References: <55F3E7A0.9020309@posteo.de> <55F3ECAC.7040508@pengutronix.de>
 <56ED45C9.7080803@posteo.de> <56ED4725.8080209@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from qmail.e-mind.com ([188.94.192.39]:58741 "HELO qmail.e-mind.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751730AbcCUJdz (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 21 Mar 2016 05:33:55 -0400
In-Reply-To: <56ED4725.8080209@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Patrick Menschel <menschel.p@posteo.de>, linux-can <linux-can@vger.kernel.org>

On 03/19/2016 01:33 PM, Marc Kleine-Budde wrote:
>>
>> Compiling to dtb and back to dts now resolves to
>>
>> 		can@01c2bc00 {
>> 			compatible = "allwinner,sun4i-a10-can";
>> 			reg = <0x1c2bc00 0x400>;
>> 			interrupts = <0x0 0x1a 0x4>;
>> 			clocks = <0x31 0x4>;
>> 			status = "okay";
>> 			pinctrl-names = "default";
>> 			pinctrl-0 = <0x32>;
>> 		};
>>
>> That does look plausible from my perspective.
>>
>> Unfortunately I'm still missing /dev/can0 and have no clue why.
>
> CAN devices are network devices and will not show up in "/dev". Have a
> look at:
>
>      ifconfig -a
>
>> If your Bpi works with legacy u-boot, I would try that next.

It is not enough having the can-core controller in dtsi only. The kernel 
has to be compiled with a network/can/socketcan enabled and the specific 
SoC can controller enabled in the same subarch structure.
i.e.: you will need to have:

in sunxi_defconfig:

CONFIG_CAN=y
CONFIG_CAN_SUN4I=y

Just my $0.2...

Hope this helps!
-- 
Eurek s.r.l.                          |
Electronic Engineering                | http://www.eurek.it
via Celletta 8/B, 40026 Imola, Italy  | Phone: +39-(0)542-609120
p.iva 00690621206 - c.f. 04020030377  | Fax:   +39-(0)542-609212
