From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [can-utils] canbusload: flush output at the end of each cycle
Date: Wed, 11 Jan 2012 12:17:11 +0100
Message-ID: <4F0D6FB7.9090407@hartkopp.net>
References: <20111221091948.GC314@e-circ.dyndns.org> <4EF2D0F3.6080909@hartkopp.net> <4F0D6EA9.4070708@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.161]:64357 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756592Ab2AKLRb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 11 Jan 2012 06:17:31 -0500
In-Reply-To: <4F0D6EA9.4070708@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org

On 11.01.2012 12:12, Marc Kleine-Budde wrote:

> On 12/22/2011 07:40 AM, Oliver Hartkopp wrote:
>> On 21.12.2011 10:19, Kurt Van Dijck wrote:
>>
>>> canbusload: flush output at the end of each cycle
>>>
>>> When canbusload is piped to another program, the output
>>> is queued for several cycles. This patch will flush the output
>>> explicitely.
>>>
>>> Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>
>>
>>
>> Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
>>
>> Tnx Kurt.
>>
>> I'll put it into the can-utils tree the next days.
> 
> nitpick:
> Oliver, please don't forget to add your S-o-b if you are pushing commits
> to the tree.


Yes. I noticed myself, that i need to improve this process by reading more git
documentation ;-)

Yesterday i just cherry-picked the patch and pushed it to the repo.

The next time i'll do it the right(TM) way :-)

Regards,
Oliver
