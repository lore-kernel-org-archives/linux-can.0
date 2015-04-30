From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: linux-can moderated?
Date: Thu, 30 Apr 2015 15:21:01 +0200
Message-ID: <55422C3D.3070309@hartkopp.net>
References: <5541E79A.2050508@gomspace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.219]:9037 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750934AbbD3NVO (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 30 Apr 2015 09:21:14 -0400
In-Reply-To: <5541E79A.2050508@gomspace.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Jeppe Ledet-Pedersen <jlp@gomspace.com>, Marc Kleine-Budde <mkl@pengutronix.de>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>

Hi Jeppe

On 30.04.2015 10:28, Jeppe Ledet-Pedersen wrote:

> I just sent in my first kernel patch yesterday. It successfully found
> its way to the linux-kernel and netdev mailing lists:
>
> http://www.spinics.net/lists/kernel/msg1977865.html
> http://www.spinics.net/lists/netdev/msg326785.html
>
> It should also have been cc'ed to linux-can@vger.kernel.org, but as far
> as I can see, it hasn't showed up in the linux-can list archives.

Yes.

And it showed up there automatically:

http://marc.info/?l=linux-can&m=143032208916337&w=2

> I
> believe the patch has to go in through the linux-can tree?

Yes.

Marc (see CC) will pick it up and commit it to the linux-can git tree at:

http://git.kernel.org/cgit/linux/kernel/git/mkl/linux-can.git/

where David Miller (net maintainer) will pull it from for upstream and stable 
trees.

So for CAN drivers linux-can ML is perfect.
No need for cross posting on Kernel/Netdev for CAN driver stuff.


> Is the list moderated for non-subscribers?

No.

> At the time I sent the patch,
> I wasn't subscribed to linux-can. Or did I do something else wrong?

No everything went fine :-)

Thanks for your contribution.

Best regards,
Oliver

