From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [PATCH 2/4] can: flexcan: add hardware controller version support
Date: Wed, 27 Jun 2012 10:56:11 +0200
Message-ID: <4FEACAAB.1000002@grandegger.com>
References: <1340785161-3598-1-git-send-email-jason77.wang@gmail.com> <1340785161-3598-2-git-send-email-jason77.wang@gmail.com> <1340785161-3598-3-git-send-email-jason77.wang@gmail.com> <4FEAC3EF.3060606@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:57405 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952Ab2F0I42 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 27 Jun 2012 04:56:28 -0400
In-Reply-To: <4FEAC3EF.3060606@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Hui Wang <jason77.wang@gmail.com>, davem@davemloft.net, shawn.guo@linaro.org, linux-can@vger.kernel.org, Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>

On 06/27/2012 10:27 AM, Marc Kleine-Budde wrote:
> On 06/27/2012 10:19 AM, Hui Wang wrote:
>> At least in the i.MX series, the flexcan contrller divides into ver_3
>> and ver_10, current driver is for ver_3 controller.
>>
>> i.MX6 has ver_10 controller, it has more reigsters than ver_3 has.
>> The rxfgmask (Rx FIFO Global Mask) register is one of the new added.
>> Its reset value is 0xffffffff, this means ID Filter Table must be
>> checked when receive a packet, but the driver is designed to accept
>> everything during the chip start, we need to clear this register to
>> follow this design.
>>
>> Add a hw_ver entry in the device tree, this can let us distinguish
>> which version the controller is, if we don't set value to this entry,
>> the hw_ver is 3 by default, this is backward compatible for existing
>> platforms like powerpc and imx35.
> 
> Is it possible to read this value from the hardware?
> Another possibility would be to introduce a new compatible device in the
> device tree.

I vote for the latter. IIRC, in the past we already had some discussion
on how to handle version dependent Flexcan hardware, e.g. by using
flexcan-vX.X or being expicit using fsl,p1010-flexcan. Search for "Add
support for powerpc" in the netdev mailing list. I added the
devicetree-discuss ml for that reason.

Wolfgang.


