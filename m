From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [RFC] CAN FD support part 2 - ideas and commented source
Date: Thu, 03 May 2012 14:50:32 +0200
Message-ID: <4FA27F18.9080106@hartkopp.net>
References: <4FA242D0.2070604@hartkopp.net> <4FA268B2.8030109@hartkopp.net> <20120503123755.GD416@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:51224 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752792Ab2ECMum (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 3 May 2012 08:50:42 -0400
Received: from [10.251.25.131] ([134.191.244.25])
	by smtp.strato.de (jorabe mo20) (RZmta 29.1 AUTH)
	with ESMTPA id z03f87o43AXNfB for <linux-can@vger.kernel.org>;
	Thu, 3 May 2012 14:50:36 +0200 (CEST)
In-Reply-To: <20120503123755.GD416@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

On 03.05.2012 14:37, Kurt Van Dijck wrote:

> Oliver,
> 
> Your proposal looks more elaborate than my first one :-)
> 
> In this email, I'll restrict myself to discussing ETH_P_CANFD.
> 
> On Thu, May 03, 2012 at 01:14:58PM +0200, Oliver Hartkopp wrote:
>> Hi all,
>>
>> in this mail i would like to document the ideas for CAN FD support pointing
>> directly to the changes inside the source.
>>
> 
> [........]
>>
>> That's it.
> 
> using dev's MTU is a very good idea!


Tnx!

> 
> Restricting the API to use one of 2 MTU's makes life easier.
> 
>>
>> Any objections / better ideas?
> I don't see benefit in introducing ETH_P_CANFD.
> Using the skb's payload length differentiates enough between CAN_MTU & CANFD_MTU.
> Why not using that info. IMHO, ETH_P_CANFD duplicates the info.


This has a big advantage when thinking about wireshark & friends.

You can look into the eth protocol and know the skb data layout.
The length information is some kind of implicit knowledge.

> 
> This part proves my point:
> @@ -69,13 +73,23 @@ static inline int can_dropped_invalid_skb(struct net_device *dev,
>  {
>  	const struct can_frame *cf = (struct can_frame *)skb->data;
>  
> -	if (unlikely(skb->len != sizeof(*cf) || cf->can_dlc > 8)) {
> This check should have become:
> +	if (unlikely(skb->len != dev->mut) || (cf->can_dlc > mtu_to_max_can_dlc(dev->mtu))
> 
> Instead of all the if then else flows here.
> A lookup table to use by mtu_to_max_can_dlc is quite straight-forward:
> static const int mtu_to_max_can_dlc_table[] = {
> 	[sizeof(struct can_frame) = CAN_MAX_DLC,
> 	[sizeof(struct canfd_frame) = CANFD_MAX_DLC,
> };


Nice idea.

How big is mtu_to_max_can_dlc_table ??
sizeof(struct canfd_frame) * sizeof(int)

Regards,
Oliver
