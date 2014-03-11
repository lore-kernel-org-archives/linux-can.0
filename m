From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Populating netdev::dev_id for udev discrimination
Date: Tue, 11 Mar 2014 20:41:44 +0100
Message-ID: <531F66F8.2060506@hartkopp.net>
References: <1394294420.3356.15.camel@NREC-014563> <531CBB6F.7090803@pengutronix.de> <531D6D3B.9020900@hartkopp.net> <20140310104650.GA456@vandijck-laurijssen.be> <531D9B6F.9010603@pengutronix.de> <531DAD8F.7090602@hartkopp.net> <531F5F14.50302@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.162]:14430 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755286AbaCKTlr (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Tue, 11 Mar 2014 15:41:47 -0400
In-Reply-To: <531F5F14.50302@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, "Christopher R. Baker" <cbaker@rec.ri.cmu.edu>
Cc: linux-can@vger.kernel.org



On 11.03.2014 20:08, Marc Kleine-Budde wrote:
> On 03/10/2014 01:18 PM, Oliver Hartkopp wrote:
>>> You can create a patch against the testing branch of linux-can-next[1]
>>
>> FYI:
>>
>> Tested with PEAK PCAN USB pro and EMS PCMCIA (both with two channels) and the
>> dev_id works like expected (first channel dev_id = 0x0, second channel 0x1).
> 
> Can I add your Tested-by for the Peak and the EMS?
> 

Oh, yes.

At least for these two adapters I checked it myself.

Thanks,
Oliver

