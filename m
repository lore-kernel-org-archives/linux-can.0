From: Matthias Fuchs <matthias.fuchs@esd.eu>
Subject: Re: Can't start ESD CAN-USB/2
Date: Mon, 17 Feb 2014 14:30:34 +0100
Message-ID: <53020EFA.9040508@esd.eu>
References: <52EBCACD.9080906@iit.it> <52EBCBFA.2090205@pengutronix.de> <52EBD794.3020503@iit.it> <52EBDCD2.6000301@pengutronix.de>,<52EBDD1D.4060503@pengutronix.de> <B83FB8757830C3428B64299F968D0F68034C56FE@IITMXWGE012.iit.local> <52EBE0D4.2060907@pengutronix.de> <52EBE25E.40707@iit.it> <52EBE3EA.6030706@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mxu02.htp-tel.de ([81.14.242.9]:58885 "EHLO mxuout02.htp-tel.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752470AbaBQNcR (ORCPT <rfc822;linux-can@vger.kernel.org>);
	Mon, 17 Feb 2014 08:32:17 -0500
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

Can you answer this question by Marc, please. Are you using a SuSE
provided kernel module or did you built it yourself? If so, how?

Are you using a 32 or 64 bit SuSE maschine?

Matthias

