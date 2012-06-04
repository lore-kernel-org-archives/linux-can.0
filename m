From: Oliver Hartkopp <oliver.hartkopp@volkswagen.de>
Subject: Re: [PATCH 2/2] net/sched: CAN Filter/Classifier
Date: Mon, 04 Jun 2012 09:14:39 +0200
Message-ID: <4FCC605F.5090103@volkswagen.de>
References: <1337937157-7680-1-git-send-email-lisovy@gmail.com> <1337937157-7680-2-git-send-email-lisovy@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mr1.volkswagen.de ([194.114.62.75]:36341 "EHLO
	mr1.volkswagen.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab2FDHO4 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 4 Jun 2012 03:14:56 -0400
In-Reply-To: <1337937157-7680-2-git-send-email-lisovy@gmail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Rostislav Lisovy <lisovy@gmail.com>
Cc: linux-can@vger.kernel.org, pisa@cmp.felk.cvut.cz, sojkam1@fel.cvut.cz

Hello Rostislav,

the merge window is closed and net-next is now open.

Please re-spin you patches based on the can-next tree

https://gitorious.org/linux-can/linux-can-next

so that Marc can include the code once it is reviewed.

As the Linux Advanced Routing & Traffic Control guys changed their mailing 
list and other setups e.g. to members only ML ( see http://lartc.org ) you 
should probably send your patch series to lartc@vger.kernel.org and put 
linux-can@vger.kernel.org in CC.

Once we got feedback from the LARTC guys (or if they do not react within a 
week or so), it's time to post the entire series on netdev@vger.kernel.org 
(with linux-can and lartc in CC).

Best regards,
Oliver


On 25.05.2012 11:12, Rostislav Lisovy wrote:
> The CAN classifier may be used with any available qdisc on Controller
> Area Network (CAN) frames passed through AF_CAN networking subsystem.
> The classifier classifies CAN frames according to their identifiers.
> It can be used on CAN frames with both SFF or EFF identifiers.
>
> The filtering rules for EFF frames are stored in an array, which
> is traversed during classification. A bitmap is used to store SFF
> rules -- one bit for each ID.
>
> More info about the project:
> http://rtime.felk.cvut.cz/can/socketcan-qdisc-final.pdf
>
> Signed-off-by: Rostislav Lisovy<lisovy@gmail.com>
> ---
>   net/sched/Kconfig   |   10 +
>   net/sched/Makefile  |    1 +
>   net/sched/cls_can.c |  571 +++++++++++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 582 insertions(+)
>   create mode 100644 net/sched/cls_can.c
>
