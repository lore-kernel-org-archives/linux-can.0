From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Re: Janz ICAN3 build warnings
Date: Wed, 29 Jan 2014 20:14:15 +0100
Message-ID: <52E95307.1030402@hartkopp.net>
References: <52E90BEB.9040608@hartkopp.net> <20140129175824.GC20561@ovro.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:40070 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbaA2TOR (ORCPT
	<rfc822;linux-can@vger.kernel.org>); Wed, 29 Jan 2014 14:14:17 -0500
In-Reply-To: <20140129175824.GC20561@ovro.caltech.edu>
Sender: linux-can-owner@vger.kernel.org
List-ID: <linux-can.vger.kernel.org>
To: "Ira W. Snyder" <iws@ovro.caltech.edu>
Cc: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>



On 29.01.2014 18:58, Ira W. Snyder wrote:
> From 90dd8d23b90d837d8d2bc5d53d0319b15f1db5a8 Mon Sep 17 00:00:00 2001
> From: "Ira W. Snyder" <iws@ovro.caltech.edu>
> Date: Wed, 29 Jan 2014 09:51:48 -0800
> Subject: [PATCH] can: janz-ican3: fix uninitialized variable warnings
> 
> Analysis of the code shows that the struct ican3_msg variable cannot be
> used uninitialized. Error conditions are checked and the loop terminates
> before calling the ican3_handle_message() function with an uninitialized
> value.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>

Yes, that fixed it!

Thanks for your fast response!

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

> ---
> 
> Hi Oliver, it looks like GCC is being stupid here. The loop obviously
> terminates before calling ican3_handle_message(). Do you agree?
> 
> I can't reproduce these warnings. Can you apply this patch and see if it
> fixes the problem for your compiler version? If so, go ahead and apply
> it.
> 
> Thanks,
> Ira
> 
>  drivers/net/can/janz-ican3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/can/janz-ican3.c b/drivers/net/can/janz-ican3.c
> index e24e6690d672..07f0ba03cd59 100644
> --- a/drivers/net/can/janz-ican3.c
> +++ b/drivers/net/can/janz-ican3.c
> @@ -1322,7 +1322,7 @@ static int ican3_napi(struct napi_struct *napi, int budget)
>  
>  	/* process all communication messages */
>  	while (true) {
> -		struct ican3_msg msg;
> +		struct ican3_msg uninitialized_var(msg);
>  		ret = ican3_recv_msg(mod, &msg);
>  		if (ret)
>  			break;
> 
