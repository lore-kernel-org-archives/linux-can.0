From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH v5 4/6] can: introduce the data bitrate configuration
 for CAN FD
Date: Fri, 28 Feb 2014 14:09:33 +0100
Message-ID: <53108A8D.6040404@hartkopp.net>
References: <1393452662-3154-1-git-send-email-socketcan@hartkopp.net> <1393452662-3154-5-git-send-email-socketcan@hartkopp.net> <530EFAA0.4090000@pengutronix.de> <530F7E6A.4050307@hartkopp.net> <53106B6B.6040307@pengutronix.de> <53107F29.1080109@hartkopp.net> <53108165.5050606@pengutronix.de> <53108210.6070700@hartkopp.net> <5310867F.8060503@pengutronix.de> <531087FB.6010008@hartkopp.net> <531089AB.2010602@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:37657 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430AbaB1NJi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 28 Feb 2014 08:09:38 -0500
In-Reply-To: <531089AB.2010602@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org, Stephane Grosjean <s.grosjean@peak-system.com>

On 28.02.2014 14:05, Marc Kleine-Budde wrote:
> On 02/28/2014 01:58 PM, Oliver Hartkopp wrote:


>> Btw. this could be a general simplification topic for the future.
> 
> Yes, removing do_set_bittiming() is a different topic.
> 
>> I do not have any objections to remove the callbacks in can_priv and call the
>> device specific functions for the (data) bittiming setting in the open
>> function then.
> 
> \o/
> 
> Can you can an Acked-by from Kurt for the whole series?

I assume you talk about Stephane ?!?

I'll send out a v8 for him for a final review.

Tnx!

Oliver

