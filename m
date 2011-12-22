From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: [can-utils] canbusload: flush output at the end of each cycle
Date: Thu, 22 Dec 2011 07:40:51 +0100
Message-ID: <4EF2D0F3.6080909@hartkopp.net>
References: <20111221091948.GC314@e-circ.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:44292 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751925Ab1LVGlB (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Thu, 22 Dec 2011 01:41:01 -0500
Received: from [192.168.178.36] (p5B0B068D.dip0.t-ipconnect.de [91.11.6.141])
	by post.strato.de (mrclete mo33) (RZmta 26.15 DYNA|AUTH)
	with ESMTPA id c0592fnBM3MvGe for <linux-can@vger.kernel.org>;
	Thu, 22 Dec 2011 07:40:49 +0100 (MET)
In-Reply-To: <20111221091948.GC314@e-circ.dyndns.org>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: linux-can@vger.kernel.org

On 21.12.2011 10:19, Kurt Van Dijck wrote:

> canbusload: flush output at the end of each cycle
> 
> When canbusload is piped to another program, the output
> is queued for several cycles. This patch will flush the output
> explicitely.
> 
> Signed-off-by: Kurt Van Dijck <kurt.van.dijck@eia.be>


Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Tnx Kurt.

I'll put it into the can-utils tree the next days.

Regards,
Oliver

> 
> This patch is available in git@gitorious.org:~kurt-vd/can-j1939-utils
> in branch regular.
> 
> diff --git a/canbusload.c b/canbusload.c
> index 26323d2..2693b9e 100644
> --- a/canbusload.c
> +++ b/canbusload.c
> @@ -201,6 +201,7 @@ void printstats(int signo)
>  	}
>  
>  	printf("\n");
> +	fflush(stdout);
>  
>  	alarm(1);
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-can" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


