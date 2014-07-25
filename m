From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] GNUmakefile.am: include canpump
Date: Fri, 25 Jul 2014 13:11:54 +0200
Message-ID: <53D23B7A.9050402@hartkopp.net>
References: <1406285604-20942-1-git-send-email-mkl@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:64889 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760132AbaGYLL7 (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Fri, 25 Jul 2014 07:11:59 -0400
In-Reply-To: <1406285604-20942-1-git-send-email-mkl@pengutronix.de>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, Ssagarr Patil <hugarsagar@outlook.com>
Cc: linux-can@vger.kernel.org

Tnx!

Applied to the canpump tree.

I tried this canpump to check out the recvmmsg() call.

But the most effective performance enhancement seemed to be the update of the
open coded ASCII conversion in this patch:

https://gitorious.org/linux-can/can-utils/commit/4a68366bac433d9e95fb74147d68d1386d62cc0a

@Sagar: Do you already use the latest can-utils containing these improvements?

Regards,
Oliver


On 25.07.2014 12:53, Marc Kleine-Budde wrote:
> This patch makes it possible to compile canpump with autotools, too.
> 
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  GNUmakefile.am | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/GNUmakefile.am b/GNUmakefile.am
> index 27767e8..1381d20 100644
> --- a/GNUmakefile.am
> +++ b/GNUmakefile.am
> @@ -38,6 +38,7 @@ bin_PROGRAMS = \
>  	cangw \
>  	canlogserver \
>  	canplayer \
> +	canpump \
>  	cansend \
>  	cansniffer \
>  	isotpdump \
> 
