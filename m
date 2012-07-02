From: Hui Wang <jason77.wang@gmail.com>
Subject: Re: [RFC PATCH] can: dev: update rx state in the can_get_echo_skb()
Date: Mon, 2 Jul 2012 11:42:18 +0800
Message-ID: <4FF1189A.8080900@gmail.com>
References: <1340876540-27840-1-git-send-email-jason77.wang@gmail.com> <20120628105948.GC418@vandijck-laurijssen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:48603 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092Ab2GBDmb (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Sun, 1 Jul 2012 23:42:31 -0400
In-Reply-To: <20120628105948.GC418@vandijck-laurijssen.be>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Hui Wang <jason77.wang@gmail.com>, mkl@pengutronix.de, shawn.guo@linaro.org, wg@grandegger.com, linux-can@vger.kernel.org

Kurt Van Dijck wrote:
> Hi,
>
> A loopback packet enters the rx interface of the CAN subsystem,
> but it had never entered the chip's receive path.
> IMHO it's bad to alter the chip's statistics the way you propose.
>   
Your explanation makes sense to me.
> Are you interested in the number of packets/bytes
> that you were able to receive on your socket?
> How about adding echo statistics in the CAN device stats,
> as shown in
> $ ip -d -s link show can0
>   
It can work.

Thanks,
Hui.
> Kind regards,
> Kurt
>
> On Thu, Jun 28, 2012 at 05:42:20PM +0800, Hui Wang wrote:
>   

