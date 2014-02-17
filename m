From: Matthias Fuchs <matthias.fuchs@esd.eu>
Subject: Re: Can't start ESD CAN-USB/2
Date: Mon, 17 Feb 2014 14:37:18 +0100
Message-ID: <5302108E.7080209@esd.eu>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de> <52EBD794.3020503@iit.it> <52EBDCD2.6000301@pengutronix.de>,<52EBDD1D.4060503@pengutronix.de> <B83FB8757830C3428B64299F968D0F68034C56FE@IITMXWGE012.iit.local> <52EBE0D4.2060907@pengutronix.de> <52EBE25E.40707@iit.it> <52EBE3EA.6030706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxu01.htp-tel.de ([81.14.242.8]:42540 "EHLO mxuout01.htp-tel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753121AbaBQNhp (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 17 Feb 2014 08:37:45 -0500
In-Reply-To: <52EBE3EA.6030706@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Francesco Giovannini <francesco.giovannini@iit.it>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Francesco,

On 01/31/2014 06:56 PM, Marc Kleine-Budde wrote:
> On 01/31/2014 06:50 PM, Francesco Giovannini wrote:
>> Yes I had to compile it myself because OpenSuse does not include it. I
>> first added it to the kernel config as a module and then ran make
>> M=./drivers/net/can/usb in the kernel source tree.
> 
> Please don't top post.
> 
> Have you used the kernel sources provided by suse? If not, try these.
> Try a different USB port on the machine, if the CAN adapter has a USB
> cable that is removable, swap it too. If it's still failing try a
> different machine.
> 
> Marc
> 
Can you answer Marc's question about the origin of the kernel module?
Did you built it yourself or are you using SuSE provided modules?
How did you built the module and from what sources?

Are you running on a 32 or 64 bit system?

Matthias
