From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [PATCH] slcanpty: declare command buffer static
Date: Mon, 13 Jan 2014 18:56:28 +0100
Message-ID: <52D428CC.3000904@hartkopp.net>
References: <1389619756-28940-1-git-send-email-yegorslists@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:48724 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751310AbaAMR4u (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Mon, 13 Jan 2014 12:56:50 -0500
In-Reply-To: <1389619756-28940-1-git-send-email-yegorslists@googlemail.com>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: yegorslists@googlemail.com, linux-can@vger.kernel.org
Cc: mkl@pengutronix.de



On 13.01.2014 14:29, yegorslists@googlemail.com wrote:
> From: Yegor Yefremov <yegorslists@googlemail.com>
> 
> ASCII command buffer char buf[200] must be declared as static,
> because it holds incomplete commands between pty2can() calls.
> Without static it is not guaranteed, that buf retains the same
> data between calls.
> 
> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Hi Yegor,

indeed the rxoffset is a static variable to handle incomplete ASCII commands
(in buf[]) and therefore it makes no sense when the referenced buffer would
not be static then ...

Thanks for catching this.

Best regards,
Oliver

> ---
>  slcanpty.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/slcanpty.c b/slcanpty.c
> index 2c1cabe..c062a02 100644
> --- a/slcanpty.c
> +++ b/slcanpty.c
> @@ -68,7 +68,7 @@ int pty2can(int pty, int socket, struct can_filter *fi,
>  {
>  	int nbytes;
>  	char cmd;
> -	char buf[200];
> +	static char buf[200];
>  	char replybuf[10]; /* for answers to received commands */
>  	int ptr;
>  	struct can_frame frame;
> 
