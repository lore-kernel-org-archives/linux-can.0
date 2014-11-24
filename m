From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Enable both CAN interfaces of BeagleBone Black
Date: Mon, 24 Nov 2014 19:13:00 +0100
Message-ID: <5473752C.8090505@hartkopp.net>
References: <54735986.2090603@ep1.ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.163]:8814 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbaKXSOM (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 24 Nov 2014 13:14:12 -0500
In-Reply-To: <54735986.2090603@ep1.ruhr-uni-bochum.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Florian Feldbauer <florian@ep1.ruhr-uni-bochum.de>, linux-can@vger.kernel.org

Hello Florian,

the problem is that the pins for DCAN0 are usually used by the I2C for the 
EEPROM that contains device-tree informations for the beagle-cape.

So you need to disable the I2C device-tree automatism (if enabled) and then 
assign the two pins to be DCAN0.

The best tutorial I've seen so far is here:
http://www.embedded-things.com/bbb/enable-canbus-on-the-beaglebone-black/

Regards,
Oliver


On 24.11.2014 17:15, Florian Feldbauer wrote:
> Hey all,
>
> I've a BeagleBone Black here, and I would like to use
> _both_ CAN interfaces of the SoC.
> Does anybody know how to enable them?
>
> I'm using the debian sd-card image from
> http://beagleboard.org/latest-images
>
> Best regards,
> Florian
>
