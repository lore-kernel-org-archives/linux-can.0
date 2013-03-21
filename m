From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: j1939 - mainline problems
Date: Thu, 21 Mar 2013 07:47:54 +0100
Message-ID: <514AAD1A.5030708@hartkopp.net>
References: <514787AD.50303@hartkopp.net> <20130321060516.GB1419@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:57383 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab3CUGr6 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 21 Mar 2013 02:47:58 -0400
In-Reply-To: <20130321060516.GB1419@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Kurt Van Dijck <kurt.van.dijck@eia.be>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 21.03.2013 07:05, Kurt Van Dijck wrote:

> On Mon, Mar 18, 2013 at 10:31:25PM +0100, Oliver Hartkopp wrote:
>> Hi Kurt,
>>
> 
>> E.g. why don't you add a j1939_priv pointer to struct dev_rcv_lists when
>> CONFIG_CAN_J1939 is enabled?
> 
> This would allow to lookup a j1939_priv struct from a netdev directly.
> That is a great idea!
> I had not thought about that yet. Partly because I did start out-of-tree :-)
> 
> I'll just go in that direction.
> Btw, It would be a struct j1939_segment * currently.
> I consider
> 	s/j1939_segment/j1939_priv/g 
> if that makes things more clear.


'priv' looks consistent from the af_can point of view, as it is a j1939
private structure attached to the generic CAN per-netdevice structure.

>>
>> Looks like j1939_segment_find() is a frequently used walkthrough function ...
>>
> Your idea of dev_rcv_lists solves that.


That's why i was pointing at this possibility :-)

Regards,
Oliver
