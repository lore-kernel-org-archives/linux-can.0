From: Wolfgang Grandegger <wg@grandegger.com>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Thu, 22 Mar 2012 10:38:40 +0100
Message-ID: <4F6AF320.7080605@grandegger.com>
References: <20120321091055.GA433@vandijck-laurijssen.be> <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de> <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de> <4F69D5D2.5080003@hartkopp.net> <20120321135339.GB6428@vandijck-laurijssen.be> <4F69EC19.7090205@grandegger.com> <4F69EE38.9000904@hartkopp.net> <20120322092456.GB426@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from ngcobalt02.manitu.net ([217.11.48.102]:38109 "EHLO
	ngcobalt02.manitu.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab2CVJit (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Mar 2012 05:38:49 -0400
In-Reply-To: <20120322092456.GB426@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Oliver Hartkopp <socketcan@hartkopp.net>, Marc Kleine-Budde <mkl@pengutronix.de>, dev@sebastianhaas.info, linux-can@vger.kernel.org

On 03/22/2012 10:24 AM, Kurt Van Dijck wrote:
> On Wed, Mar 21, 2012 at 04:05:28PM +0100, Oliver Hartkopp wrote:
>> On 21.03.2012 15:56, Wolfgang Grandegger wrote:
>>
>>> Also DLC=9 means 12 bytes, DLC=10 means 16 bytes, DLC=15 means 64 bytes.
>>> This may even change in the final spec.
>>
>> Yep!
> 
> Although the precise coding is not final yet, I'd propose to not use that coding
> in the ABI for these reasons:
> * The reason of fitting a DLC in 4 bits makes sense on the wire
>   but not on the ABI. We still use an u8!
> * Decoding & encoding between real length & DLC IMO is best done next to the
>   chips register access.

I was speaking of the frame's DLC field. The app/abi should support any
integer length, of course.

>>>>> 3. Will these differences be visible in the CAN registers? Is this relevant?
>>>> Without hardware, it's a bit early to predict. I guess it will be visible, but
>>>> not relevant since that's driver stuff.
>>>
>>> As CANFD controllers also supports CAN2.0 frames, they must provide the
>>> the relevant information somehow, similar to EFF and SFF.
> I doubt this.
> EFF & SFF share the same bus. CANFD vs. CAN2.0 is not a per-frame thing. You
> have configured it yourself at chip initialization time...

Why not? A CANFD capable controller should be able to distinguish
between a legacy and a CANFD frame by looking to the BRS bit in the frame.

Wolfgang.

