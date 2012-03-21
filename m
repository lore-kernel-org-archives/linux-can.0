From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] can: Introducing CANFD for af_can & can-raw
Date: Wed, 21 Mar 2012 16:26:57 +0100
Message-ID: <4F69F341.20504@hartkopp.net>
References: <20120321091055.GA433@vandijck-laurijssen.be> <E1SAIM4-0007a6-Sf@smtprelay03.ispgateway.de> <20120321110502.GA3372@vandijck-laurijssen.be> <4F69BEE3.2040705@pengutronix.de> <20120321120846.GB3372@vandijck-laurijssen.be> <4F69CA74.3020607@pengutronix.de> <4F69D5D2.5080003@hartkopp.net> <20120321135339.GB6428@vandijck-laurijssen.be> <4F69EA75.1070202@hartkopp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:46142 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab2CUP07 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 21 Mar 2012 11:26:59 -0400
In-Reply-To: <4F69EA75.1070202@hartkopp.net>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: linux-can@vger.kernel.org

On 21.03.2012 15:49, Oliver Hartkopp wrote:

> On 21.03.2012 14:53, Kurt Van Dijck wrote:

>>> IMO we need to introduce a new struct canfd_frame
>> IMO we need not to introduce a new struct since they are logically equivalent.
>>
>> I created an old can20b_frame just to compute the sizeof.
>> I'd go for a combined can_frame that could hold both.
> 
> 
> No. You only think of CAN_RAW. There might be a way to do it with CAN_RAW but
> changing an exported visible userspace structure breaks the ABI.
> 
> Expect that we can never change struct can_frame as this is written into stone.


Answering myself, but here's a very recent statement from Linus focussing
binary compatibility:

http://thread.gmane.org/gmane.linux.kernel/1245999/focus%3D1264170

Indeed we once broke the ABI when fixing the EFF/SFF filters reported by
yourself. But this was a very simple thing in one bit that has not been
handled correctly in opposite to change struct can_frame ...

Regards,
Oliver
