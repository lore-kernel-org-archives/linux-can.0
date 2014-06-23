From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [Gitorious] Activity: prabhakar requested a merge of prab...
Date: Mon, 23 Jun 2014 18:12:12 +0200
Message-ID: <53A851DC.2060801@hartkopp.net>
References: <53a829dc98811_78d23ff48250bea851769@ratt.gitorious.c.bitbit.net.mail>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:60385 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbaFWQMP (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 23 Jun 2014 12:12:15 -0400
In-Reply-To: <53a829dc98811_78d23ff48250bea851769@ratt.gitorious.c.bitbit.net.mail>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: prabhakar.csengg@gmail.com
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Prabhakar,

thanks for your patch.

Can you please send it with git send-email to the mailing list for a review?

Additionally:

Does this patch introduce any backward compatibility restrictions (e.g. you
need at least the includes from 2.6.14+ to build candump ...).

You only provide to configure a value for SCHED_RR.
Does it make sense to provide other scheduling policies too?

Regards,
Oliver


On 23.06.2014 15:21, Gitorious wrote:
> 
> Hello hartkopp,
> 
> One of your favorites has a new activity:
> ------------------------------------------------------------------------
> prabhakar requested a merge of prabhakar-can-utils with can-utils.
> The merge request is at https://gitorious.org/linux-can/can-utils/merge_requests/2
> ------------------------------------------------------------------------
> 
> You are receiving this email because you have chosen to be notified by
> email whenever this favorite has new activity. You can manage your
> favorite subscriptions at https://gitorious.org/favorites
> 
