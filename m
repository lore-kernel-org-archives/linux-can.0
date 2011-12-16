From: David Miller <davem@davemloft.net>
Subject: Re: the linux-can-next tree
Date: Fri, 16 Dec 2011 16:14:16 -0500 (EST)
Message-ID: <20111216.161416.1158979823905609381.davem@davemloft.net>
References: <20111201.130907.1276930495409347261.davem@davemloft.net>
	<4ED7DDBA.9090201@pengutronix.de>
	<4EE5C5D0.5030805@pengutronix.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([198.137.202.13]:58953 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760696Ab1LPVSi (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 16 Dec 2011 16:18:38 -0500
In-Reply-To: <4EE5C5D0.5030805@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: mkl@pengutronix.de
Cc: socketcan@hartkopp.net, wg@grandegger.com, netdev@vger.kernel.org, linux-can@vger.kernel.org, urs@isnogud.escape.de

From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Mon, 12 Dec 2011 10:13:52 +0100

> Hello David,
> 
> On 12/01/2011 09:04 PM, Marc Kleine-Budde wrote:
>>> I said I want one person.  One person who periodically send me GIT pull requests
>>> or a patch series for "CAN updates" of all kinds.
>> 
>> We're currently discussing the problem and we understood the one person
>> contact policy.
> 
> We decided that I should be this person. Our can tree is located on
> gitorious:
> 
> https://gitorious.org/linux-can/linux-can-next

Let me know when you formally want me to pull from this.  Typically this is
done by posting a "N patch" series to netdev, one for each change, CC:'d
to me.

The first posting should be with a subject like "[PATCH 0/N] CAN updates"
and contain the pull request as well as the top-level diffstate et al.
of the pull, usually generated using "git request-pull"
